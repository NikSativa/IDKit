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

    subscript(_ id: ID<Element>) -> Element {
        return first(with: id).unsafelyUnwrapped
    }

    subscript(safe id: ID<Element>) -> Element? {
        return first(with: id)
    }

    /// Secure storage
    /// - return: element that was replaced by new
    @discardableResult
    mutating func insert(_ element: Element) -> Element? {
        if let ind = firstIndex(with: element.id) {
            let old = self[ind]
            self[ind] = element
            return old
        }
        append(element)
        return nil
    }
}
