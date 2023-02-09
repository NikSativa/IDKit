import Foundation

public struct AnyID: Hashable, Codable {
    private enum Variants: Hashable {
        case string(String)
        case int(Int)
    }

    private let id: Variants

    public var asString: String {
        switch id {
        case .string(let value):
            return value
        case .int(let value):
            return String(value)
        }
    }

    public var asInt: Int? {
        switch id {
        case .string(let value):
            return Int(value)
        case .int(let value):
            return value
        }
    }

    public init(_ id: String) {
        self.id = .string(id)
    }

    public init(_ id: Int) {
        self.id = .int(id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch id {
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let value = try container.decode(String.self)
            self.id = .string(value)
        } catch {
            let value = try container.decode(Int.self)
            self.id = .int(value)
        }
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.asString == rhs.asString
    }

    public func asTypedID<I: IDRepresentable>() -> ID<I> where I.RawIdentifier == AnyID {
        return .init(rawValue: self)
    }
}

// MARK: - CustomStringConvertible

extension AnyID: CustomStringConvertible {
    public var description: String {
        switch id {
        case .string(let value):
            return "str(\(value))"
        case .int(let value):
            return "int(\(value))"
        }
    }
}

// MARK: - Comparable

extension AnyID: Comparable {
    public static func <(lhs: AnyID, rhs: AnyID) -> Bool {
        switch (lhs.id, rhs.id) {
        case (.int(let a), .int(let b)):
            return a < b
        case (.string(let a), .string(let b)):
            return a < b
        case (.int(let a), .string(let b)):
            return String(a) < b
        case (.string(let a), .int(let b)):
            return a < String(b)
        }
    }
}
