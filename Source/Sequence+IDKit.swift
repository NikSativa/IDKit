import Foundation

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
