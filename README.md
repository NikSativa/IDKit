# IDKit
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FIDKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/NikSativa/IDKit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FIDKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/NikSativa/IDKit)

Simple and lightweight library that provides a set of classes and functions to work with identifiers.

### AnyID
No longer need to use `String` or `Int` for your identifiers. Just use `AnyID` and forget about type casting.

```swift
struct User: Codable {
    let id: AnyID
    let name: String
    let age: Int
}
```

### TypedID
`TypedID<...>` represents an identifier as a strong type identifier.
**TID<...>** - abbreviation for easy using

### IDRepresentable
Protocol can be used to define your custom identifier types.

```swift
struct User: IDRepresentable {
    // let id: AnyID  <-- property is not required
    let name: String
    let age: Int
}

// but in any place you can identify your strong type id
let identifier: TID<User> 
```

### IDContract
It's like combine of TypedID/TID and IDRepresentable protocols. It's required to have a property with name `id` of type `TypedID<Self>`.
The library automatically confirms the `Swift.Identifiable` protocol with the `id` property of the `TypedID<Self>` type.

```swift
struct User: IDContract {
    let id: TypedID<Self> <-- property is required
}
```

## Known issue: **SwiftUI+Preview** crash
Based on bug in **SwiftUI+Preview** that is crashing when using **ForEach** with  **IDContract** models which conforms **Identifiable** by default
It's a bug in **SwiftUI+Preview**, not in this package.
**Some times it works, but sometimes it crashes...**

- ⚠️ If you don't use **SwiftUI+Preview**, then you definitely won't need this code!
- This is a workaround to fix the crash and show **SwiftUI+Preview**. You can use **Simulator** without that workaround to avoid this crash.
- Xcode 15.4 is still crashing, **waiting for a fix in Xcode 16.0**... or in future versions from Apple 🤷‍♂️

### Usage
```swift
ForEach(.fixID($items)) { item in
    // take the properties from the item directly
    let some = item.some
    // or
    // take the original item
    let item = item.original
}
```

### Crash log 
```
== PREVIEW UPDATE ERROR:

LinkDylibError: Failed to build RoutesView.swift

Linking failed: linker command failed with exit code 1 (use -v to see invocation)

ld: warning: search path '/Applications/Xcode.app/Contents/SharedFrameworks-iphonesimulator' not found
ld: warning: Could not find or use auto-linked framework 'CoreAudioTypes': framework 'CoreAudioTypes' not found
Undefined symbols for architecture arm64:
"nominal type descriptor for IDKit.TypedID", referenced from:
```
