import Foundation
import NAnyID

public extension ID {
    func testMake(rawValue: Value.RawIdentifier) -> Self {
        return .init(rawValue: rawValue)
    }
}

// MARK: - Comparable

public extension ID where Value.RawIdentifier: Comparable {
    static func ==(lhs: Self, rhs: Value.RawIdentifier) -> Bool {
        return lhs.rawValue == rhs
    }

    static func ==(lhs: Value.RawIdentifier, rhs: Self) -> Bool {
        return lhs == rhs.rawValue
    }
}
