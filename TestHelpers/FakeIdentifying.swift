import AnyID
import Foundation
import NSpry

final class FakeIdentifying: Identifying, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case id
    }

    var id: ID<FakeIdentifying> {
        return spryify()
    }
}
