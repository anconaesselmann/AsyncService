//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

public struct QueryP {
    public let key: String
    public let value: String

    public init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }

    public init(_ key: String, _ value: Int) {
        self.key = key
        self.value = String(value)
    }
}
