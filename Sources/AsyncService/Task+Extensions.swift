//  Created by Axel Ancona Esselmann on 7/25/24.
//

import Foundation
import Combine

extension Task {
    func eraseToAnyCancellable() -> AnyCancellable {
        AnyCancellable(cancel)
    }
}
