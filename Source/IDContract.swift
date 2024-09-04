import Foundation

@available(*, deprecated, renamed: "IDContract", message: "Use IDContract instead of `Identifying`, which is not similar in name to Swift's `Identifiable` protocol.")
public typealias Identifying = IDContract

public protocol IDContract: IDRepresentable, Identifiable {
    var id: TypedID<Self> { get }
}

public extension Sequence where Element: IDContract {
    func contains(idContract element: Element) -> Bool {
        return contains { original in
            return original.id == element.id
        }
    }

    func contains(id: TypedID<Element>) -> Bool {
        return contains { original in
            return original.id == id
        }
    }

    func first(with id: TypedID<Element>) -> Element? {
        return first { original in
            return original.id == id
        }
    }
}

public extension Array where Element: IDContract {
    func firstIndex(with id: TypedID<Element>) -> Self.Index? {
        return firstIndex { original in
            return original.id == id
        }
    }

    subscript(_ id: TypedID<Element>) -> Element {
        return first(with: id).unsafelyUnwrapped
    }

    subscript(safe id: TypedID<Element>) -> Element? {
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
