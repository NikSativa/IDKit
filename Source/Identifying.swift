import Foundation

public protocol Identifying: IDRepresentable {
    var id: ID<Self> { get }
}

public extension Sequence where Element: Identifying {
    func contains(identifyingElement element: Element) -> Bool {
        return contains { original in
            return original.id == element.id
        }
    }

    func contains(id: ID<Element>) -> Bool {
        return contains { original in
            return original.id == id
        }
    }

    func first(with id: ID<Element>) -> Element? {
        return first { original in
            return original.id == id
        }
    }
}

public extension Array where Element: Identifying {
    func firstIndex(with id: ID<Element>) -> Self.Index? {
        return firstIndex { original in
            return original.id == id
        }
    }
}
