//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

public protocol ResponseType {
    associatedtype Model

    var value: Model { get }
}

public extension ResponseType {
    func map<Result>(
        _ transform: (Model) throws -> Result
    ) throws -> Result {
        try transform(value)
    }

    func mapResponse<Result>(
        _ transform: (Model) throws -> Result
    ) throws -> Response<Result> {
        Response<Result>(
            value: try transform(value)
        )
    }

    func with<Item>(
        _ item: Item,
        do block: (Item, Self) -> Void
    ) -> Self {
        block(item, self)
        return self
    }

    func with<Item>(
        _ item: inout Item,
        do block: (inout Item, Model) -> Void
    ) -> Self {
        block(&item, value)
        return self
    }
}

public extension ResponseType where Model == Data {
    func decoded<Mapped>(
        _ type: Mapped.Type,
        using decoder: JSONDecoder
    ) throws -> Response<Mapped>
        where Mapped: Decodable
    {
        Response<Mapped>(
            value: try decoder.decode(type, from: value)
        )
    }
}
