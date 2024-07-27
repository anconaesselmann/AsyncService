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

    private static func groupDir(_ group: String) -> URL? {
        guard let url = cacheDir?.appending(path: group) else {
            return nil
        }
        if !FileManager.default.fileExists(atPath: url.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                assertionFailure("Could not create \(url.absoluteString), \(error)")
                return url
            }
        }
        return url
    }

    public init() {
        guard let cacheDir = Self.cacheDir else {
            return
        }
        try? FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true)
    }

    public func cache<Value, ID>(value: Value, for id: ID, group: String?) throws
        where Value: Codable, ID: Hashable
    {
        guard let localUrl = Self.localUrl(for: id, group: group) else {
            return
        }
        let data = try encoder.encode(value)
        try? data.write(to: localUrl)
    }

    public func value<Value>(for id: any Hashable, group: String?) throws -> Value?
        where Value: Codable
    {
        guard let localUrl = Self.localUrl(for: id, group: group) else {
            return nil
        }
        let data = try Data(contentsOf: localUrl)
        return try decoder.decode(Value.self, from: data)
    }

    public func disabled() -> Bool {
        isDisabled
    }

    private static func localUrl(for id: any Hashable, group: String?) -> URL? {
        let idString = String(id: id)
        var url = Self.cacheDir
        if let group = group {
            url = groupDir(group)
        }
        return url?.appending(path: idString + ".json")
    }
}
