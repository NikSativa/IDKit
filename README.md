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

### ID
`ID` represents an identifier as a strong type identifier.

### IDRepresentable
Protocol can be used to define your custom identifier types.

```swift
struct User: IDRepresentable {
    // let id: AnyID  <-- property is not required
    let name: String
    let age: Int
}

// but in any place you can identify your strong type id
let identifier: ID<User> 
```

### Identifying
It's like combine of ID and IDRepresentable protocols. It's required to have a property with name `id` of type `ID<Self>`.

```swift
struct User: Identifying {
    let id: ID<Self> <-- property is required
}
```
