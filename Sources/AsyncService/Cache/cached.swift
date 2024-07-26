//  Created by Axel Ancona Esselmann on 7/25/24.
//

import Foundation

public func cached<T, ID>(
    _ id: ID,
    skip: Bool = false,
    cache: JsonCacheType = JsonFileCache.shared,
    operation: @escaping @Sendable () async throws -> T
) async throws -> T
    where T: Codable, ID: Hashable
{
    if 
        !skip,
        await !cache.disabled(),
        let cached: T = try? await cache.value(for: id)
    {
//        print("from cache: \(id)")
        return cached
    } else {
//        print("fetching: \(id)")
        let value = try await operation()
        try await cache.cache(value: value, for: id)
        return value
    }
}
