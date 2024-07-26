//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

public enum UrlQueryEncodingError: Swift.Error {
    case invalidString
}

public extension StringProtocol {
    func urlQueryEncoded() throws -> String {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw UrlQueryEncodingError.invalidString
        }
        return encoded
    }
}
