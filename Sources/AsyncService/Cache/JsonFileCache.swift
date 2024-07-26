//  Created by Axel Ancona Esselmann on 7/25/24.
//

import Foundation
import CryptoKit

@globalActor
public actor JsonFileCache: JsonCacheType {
    public static let shared = JsonFileCache()

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private var isDisabled: Bool = false

    public func set(disabled: Bool) {
        isDisabled = disabled
    }

    private static var cacheDir: URL? {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appending(path: "json_cache")
    }

    public init() {
        guard let cacheDir = Self.cacheDir else {
            return
        }
        try? FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true)
    }

    public func cache<Value, ID>(value: Value, for id: ID) throws
        where Value: Codable, ID: Hashable
    {
        guard let localUrl = Self.localUrl(for: id) else {
            return
        }
        let data = try encoder.encode(value)
        try? data.write(to: localUrl)
    }

    public func value<Value>(for id: any Hashable) throws -> Value?
        where Value: Codable
    {
        guard let localUrl = Self.localUrl(for: id) else {
            return nil
        }
        let data = try Data(contentsOf: localUrl)
        return try decoder.decode(Value.self, from: data)
    }

    public func disabled() -> Bool {
        isDisabled
    }

    private static func hash(url: URL) -> String {
        let data = Data(url.absoluteString.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }

    private static func localUrl(for id: any Hashable) -> URL? {
        let idString = String(id: id)
        return Self.cacheDir?.appending(path: idString + ".json")
    }
}
