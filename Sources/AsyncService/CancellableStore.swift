//  Created by Axel Ancona Esselmann on 7/25/24.
//

import Foundation
import Combine

@MainActor
public class CancellableStore {
    public static let shared = CancellableStore()

    @MainActor
    private var cancellables: [AnyHashable: AnyCancellable] = [:]

    public func insert<ID>(_ cancellable: AnyCancellable, for id: ID) where ID: Hashable {
        cancellables[id] = cancellable
    }

    public func clear<ID>(_ id: ID) where ID: Hashable {
        if has(id) {
            cancellables[id] = nil
        }
    }

    public func has<ID>(_ id: ID) -> Bool where ID: Hashable {
        cancellables[id] != nil
    }
}
