import Foundation
import IDKit
import SpryKit

public final class FakeIdentifying: Identifying, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case id
    }

    public var id: ID<FakeIdentifying> {
        return spryify()
    }
}
