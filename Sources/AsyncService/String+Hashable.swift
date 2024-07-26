//  Created by Axel Ancona Esselmann on 7/25/24.
//

import Foundation

public extension String {
    init<ID>(id: ID) where ID: Hashable {
        self = .init(ids: id)
    }

    init(ids: (any Hashable)..., separator: String = "_") {
        self = ids
            .map { "\($0)" }
            .joined(separator: separator)
    }
}
