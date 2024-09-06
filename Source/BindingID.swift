#if canImport(SwiftUI)
import Foundation
import SwiftUI

/// Based on bug in **SwiftUI+Preview** that is crashing when using **ForEach** with  **IDContract** models which conforms **Identifiable** by default
/// It's a bug in **SwiftUI+Preview**, not in this package.
/// **Some times it works, but sometimes it crashes...**
///
/// - Attention: ⚠️ If you don't use **SwiftUI+Preview**, then you definitely won't need this code!
/// - Note: This is a workaround to fix the crash and show **SwiftUI+Preview**. You can use **Simulator** without that workaround to avoid this crash.
/// - Remark: Xcode 15.4 is still crashing, waiting for a fix in Xcode 16.0... or in future versions from Apple 🤷‍♂️
///
/// ## Usage
/// ```swift
/// ForEach(.fixID($items)) { item in
///     // take the properties from the item directly
///     let some = item.some
///     // or
///     // take the original item
///     let item = item.original
/// }
/// ```
///
/// ## Crash log
/// ```
/// == PREVIEW UPDATE ERROR:
///
/// LinkDylibError: Failed to build RoutesView.swift
///
/// Linking failed: linker command failed with exit code 1 (use -v to see invocation)
///
/// ld: warning: search path '/Applications/Xcode.app/Contents/SharedFrameworks-iphonesimulator' not found
/// ld: warning: Could not find or use auto-linked framework 'CoreAudioTypes': framework 'CoreAudioTypes' not found
/// Undefined symbols for architecture arm64:
/// "nominal type descriptor for IDKit.TypedID", referenced from:
/// ```
@dynamicMemberLookup
public struct BindingID<State: IDContract>: Identifiable {
    public typealias ID = String

    public let id: String
    public var original: State

    public init(_ state: Binding<State>, idTransform: (TypedID<State>) -> String) {
        self.id = idTransform(state.wrappedValue.id)
        self.original = state.wrappedValue
    }

    public init(_ state: Binding<State>) where State.RawIdentifier == AnyID {
        self.init(state, idTransform: \.asString)
    }

    public init(_ state: Binding<State>) where State.RawIdentifier == String {
        self.init(state, idTransform: \.rawValue)
    }

    public init(_ state: Binding<State>) where State.RawIdentifier == Int {
        self.init(state, idTransform: { "\($0)" })
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        return original[keyPath: keyPath]
    }

    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<State, Value>) -> Value {
        get {
            return original[keyPath: keyPath]
        }
        set {
            original[keyPath: keyPath] = newValue
        }
    }
}

public extension Binding {
    static func fixID<T: IDContract>(_ arr: Binding<[T]>) -> Binding<[BindingID<T>]>
    where T.RawIdentifier == AnyID {
        return arr.transform(\.asString)
    }

    static func fixID<T: IDContract>(_ arr: Binding<[T]>) -> Binding<[BindingID<T>]>
    where T.RawIdentifier == String {
        return arr.transform {
            return $0.rawValue
        }
    }

    static func fixID<T: IDContract>(_ arr: Binding<[T]>) -> Binding<[BindingID<T>]>
    where T.RawIdentifier == Int {
        return arr.transform {
            return "\($0)"
        }
    }
}

private extension Binding {
    func transform<T>(_ idTransform: @escaping (TypedID<T>) -> String) -> Binding<[BindingID<T>]> where Self == Binding<[T]>, T: IDContract {
        return .init(get: {
            var result: [BindingID<T>] = []
            for item in self {
                result.append(BindingID(item, idTransform: idTransform))
            }
            return result
        },
                     set: {
            self.wrappedValue = $0.map(\.original)
        })
    }
}

#endif
