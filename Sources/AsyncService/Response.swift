//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

public struct ExtendedResponse<Value>: ResponseType {
    public let value: Value
    public let response: URLResponse

    public func urlResponse(_ block: (URLResponse) throws -> Void) throws -> Response<Value> {
        try block(response)
        return Response(value: value)
    }
}

public struct Response<Value>: ResponseType {
    public let value: Value
}
