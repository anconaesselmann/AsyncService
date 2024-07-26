//  Created by Axel Ancona Esselmann on 7/25/24.
//

import Foundation

public protocol JsonCacheType {
    func disabled() async -> Bool
    func cache<Value, ID>(value: Value, for id: ID) async throws where Value: Codable, ID: Hashable
    func value<Value>(for id: any Hashable) async throws -> Value? where Value: Codable
}

public extension JsonCacheType {
    func disabled() async -> Bool {
        false
    }
}
