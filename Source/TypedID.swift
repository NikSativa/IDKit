import Foundation

/// abbreviation for easy using
public typealias TID<T: IDRepresentable> = TypedID<T>

public struct TypedID<Value: IDRepresentable>: Hashable {
    public let rawValue: Value.RawIdentifier

    public init(rawValue: Value.RawIdentifier) {
        self.rawValue = rawValue
    }

    public func map<I: IDRepresentable>() -> TypedID<I> where I.RawIdentifier == Value.RawIdentifier {
        return TypedID<I>(rawValue: rawValue)
    }
}

// MARK: - Comparable

extension TypedID: Comparable where Value.RawIdentifier: Comparable {
    public static func <(lhs: TypedID<Value>, rhs: TypedID<Value>) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Decodable

extension TypedID: Decodable where Value.RawIdentifier: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(Value.RawIdentifier.self)
    }
}

// MARK: - Encodable

extension TypedID: Encodable where Value.RawIdentifier: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

// MARK: - String

public extension TypedID where Value.RawIdentifier == AnyID {
    init(_ value: String) {
        self.init(rawValue: .init(value))
    }

    init(_ value: Int) {
        self.init(rawValue: .init(value))
    }

    var asString: String {
        return rawValue.asString
    }

    static var uuid: Self {
        return .init(rawValue: .uuid)
    }
}

public extension TypedID where Value.RawIdentifier == String {
    init(_ value: String) {
        self.init(rawValue: value)
    }

    static var uuid: Self {
        return .init(rawValue: UUID().uuidString)
    }
}

// MARK: - ExpressibleByUnicodeScalarLiteral

extension TypedID: ExpressibleByUnicodeScalarLiteral where Value.RawIdentifier == AnyID {
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
}

// MARK: - ExpressibleByExtendedGraphemeClusterLiteral

extension TypedID: ExpressibleByExtendedGraphemeClusterLiteral where Value.RawIdentifier == AnyID {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

// MARK: - ExpressibleByStringLiteral

extension TypedID: ExpressibleByStringLiteral where Value.RawIdentifier == AnyID {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

// MARK: - CustomStringConvertible

extension TypedID: CustomStringConvertible where Value.RawIdentifier: CustomStringConvertible {
    public var description: String {
        return rawValue.description
    }
}
