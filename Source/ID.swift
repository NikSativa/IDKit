import Foundation

public struct ID<Value: IDRepresentable>: Hashable {
    public let rawValue: Value.RawIdentifier

    public init(rawValue: Value.RawIdentifier) {
        self.rawValue = rawValue
    }

    public func map<I: IDRepresentable>() -> ID<I> where I.RawIdentifier == Value.RawIdentifier {
        return ID<I>(rawValue: rawValue)
    }
}

public extension ID where Value.RawIdentifier == AnyID {
    var asString: String {
        return rawValue.asString
    }
}

// MARK: - Comparable

extension ID: Comparable where Value.RawIdentifier: Comparable {
    public static func <(lhs: ID<Value>, rhs: ID<Value>) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Decodable

extension ID: Decodable where Value.RawIdentifier: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(Value.RawIdentifier.self)
    }
}

// MARK: - Encodable

extension ID: Encodable where Value.RawIdentifier: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

// MARK: - String

public extension ID where Value.RawIdentifier == AnyID {
    init(_ value: String) {
        self.init(rawValue: .init(value))
    }

    init(_ value: Int) {
        self.init(rawValue: .init(value))
    }

    static var uuid: Self {
        return .init(UUID().uuidString)
    }
}

public extension ID where Value.RawIdentifier == String {
    init(_ value: String) {
        self.init(rawValue: value)
    }

    static var uuid: Self {
        return .init(rawValue: UUID().uuidString)
    }
}

// MARK: - CustomStringConvertible

extension ID: CustomStringConvertible where Value.RawIdentifier: CustomStringConvertible {
    public var description: String {
        return rawValue.description
    }
}
