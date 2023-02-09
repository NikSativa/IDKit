import Foundation

public protocol IDRepresentable {
    associatedtype RawIdentifier: Hashable = AnyID
}
