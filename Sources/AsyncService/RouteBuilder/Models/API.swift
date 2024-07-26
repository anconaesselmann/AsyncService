//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

public struct API {
    let domain: String
    let decoder: JSONDecoder
    let session: URLSessionType

    public init(
        _ domain: String,
        decoder: JSONDecoder = JSONDecoder(),
        session: URLSessionType = URLSession.shared
    ) {
        self.domain = domain
        self.decoder = decoder
        self.session = session
    }

    public func makeUrl(@URLBuilder _ content: () -> URLComponents) -> URL {
        let components = content()
        var combined = URLComponents(string: domain)!
        combined.path = "/" + components.path
        if !(components.queryItems ?? []).isEmpty {
            combined.queryItems = components.queryItems
        } else {
            combined.queryItems = nil
        }
        return combined.url!
    }

    @MainActor
    public func cancel<ID>(_ id: ID) where ID: Hashable {
        CancellableStore.shared.clear(id)
    }
}
