import Foundation

@available(*, deprecated, renamed: "IDContract", message: "Use IDContract instead of `Identifying`, which is not similar in name to Swift's `Identifiable` protocol.")
public typealias Identifying = IDContract

public protocol IDContract: IDRepresentable, Identifiable<TypedID<Self>> {
    var id: TypedID<Self> { get }
}
