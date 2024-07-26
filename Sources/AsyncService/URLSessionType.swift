//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

public protocol URLSessionType: AnyObject {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType { }

public extension URLSessionType {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await self.data(from: url, delegate: nil)
    }
}

public extension URLSessionType {
    func dataResponse(
        from url: URL,
        delegate: (any URLSessionTaskDelegate)? = nil,
        onURLResponse urlResponseBlock: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Response<Data> {
        let (data, response) = try await self.data(from: url, delegate: delegate)
        try urlResponseBlock?(response)
        return Response(value: data)
    }

    func fetch<Model>(
        _ type: Model.Type,
        using decoder: JSONDecoder = JSONDecoder(),
        from url: URL,
        delegate: (any URLSessionTaskDelegate)? = nil,
        onURLResponse urlResponseBlock: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Response<Model>
    where Model: Decodable
    {
        try await dataResponse(from: url, delegate: delegate, onURLResponse: urlResponseBlock)
            .decoded(type, using: decoder)
    }

    func fetchModel<Model>(
        _ type: Model.Type,
        using decoder: JSONDecoder = JSONDecoder(),
        from url: URL,
        delegate: (any URLSessionTaskDelegate)? = nil,
        onURLResponse: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Model
    where Model: Decodable
    {
        try await fetch(type, using: decoder, from: url, delegate: delegate, onURLResponse: onURLResponse)
            .value
    }
}

public extension URLSessionType {
    private func dataTaskResponse(
        from url: URL,
        priority: TaskPriority? = nil,
        delegate: (any URLSessionTaskDelegate)? = nil,
        onURLResponse urlResponseBlock: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Task<Response<Data>, any Error> {
        Task(
            priority: priority,
            operation: { [weak self] in
                guard let self = self else {
                    throw CancellationError()
                }
                let (data, response) = try await self.data(
                    from: url,
                    delegate: delegate
                )
                try Task.checkCancellation()
                try urlResponseBlock?(response)
                return Response(value: data)
            }
        )
    }

    func fetch<Model, ID>(
        _ type: Model.Type,
        using decoder: JSONDecoder = JSONDecoder(),
        from url: URL,
        priority: TaskPriority? = nil,
        cancelWith id: ID,
        delegate: (any URLSessionTaskDelegate)? = nil,
        onURLResponse urlResponseBlock: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Response<Model>
    where Model: Decodable, ID: Hashable
    {
        let task = try await dataTaskResponse(
            from: url,
            priority: priority,
            delegate: delegate,
            onURLResponse: urlResponseBlock
        )
        await CancellableStore.shared.insert(task.eraseToAnyCancellable(), for: id)
        let decoded = try await task.value
            .decoded(type, using: decoder)
        await CancellableStore.shared.clear(id)
        return decoded
    }
}
