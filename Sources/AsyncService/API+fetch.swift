//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

public extension API {
    func fetch<Model>(
        _ type: Model.Type,
        using decoder: JSONDecoder? = nil,
        delegate: (any URLSessionTaskDelegate)? = nil,
        @URLBuilder for content: () -> URLComponents,
        onURLResponse: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Response<Model>
        where Model: Decodable
    {
        try await session.fetch(
            type, 
            using: decoder ?? self.decoder,
            from: makeUrl(content),
            delegate: delegate,
            onURLResponse: onURLResponse
        )
    }

    func fetch<Model>(
        _ type: Model.Type,
        using decoder: JSONDecoder? = nil,
        for path: Path,
        _ parameters: [QueryP],
        delegate: (any URLSessionTaskDelegate)? = nil,
        onURLResponse: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Response<Model>
        where Model: Decodable
    {
        try await fetch(
            type,
            using: decoder ?? self.decoder,
            delegate: delegate,
            for: {
                path
                parameters
            },
            onURLResponse: onURLResponse
        )
    }
}

public extension API {
    func fetch<Model, ID>(
        _ type: Model.Type,
        using decoder: JSONDecoder? = nil,
        cancelWith id: ID,
        delegate: (any URLSessionTaskDelegate)? = nil,
        @URLBuilder for content: () -> URLComponents,
        onURLResponse: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Response<Model>
    where Model: Decodable, ID: Hashable
    {
        try await session.fetch(
            type,
            using: decoder ?? self.decoder,
            from: makeUrl(content),
            cancelWith: id,
            delegate: delegate,
            onURLResponse: onURLResponse
        )
    }

    func fetch<Model, ID>(
        _ type: Model.Type,
        using decoder: JSONDecoder? = nil,
        for path: Path,
        _ parameters: [QueryP] = [],
        cancelWith id: ID,
        delegate: (any URLSessionTaskDelegate)? = nil,
        onURLResponse: ((URLResponse) throws -> Void)? = nil
    ) async throws -> Response<Model>
        where Model: Decodable, ID: Hashable
    {
        try await fetch(
            type,
            using: decoder ?? self.decoder,
            cancelWith: id,
            delegate: delegate,
            for: {
                path
                parameters
            },
            onURLResponse: onURLResponse
        )
    }
}
