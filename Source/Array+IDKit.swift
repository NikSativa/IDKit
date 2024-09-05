import Foundation

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
