import Foundation
import SpryKit
import XCTest
@testable import IDKit

final class IDRepresentableTests: XCTestCase {
    private struct CodableUser: IDRepresentable, Equatable, Codable {
        let id: TypedID<Self>
    }

    func test_encodable() throws {
        let user: CodableUser = .init(id: "123")
        let data = try JSONEncoder().encode(user)
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        XCTAssertEqual(object as? [String: String], ["id": "123"])
    }

    func test_decodable() throws {
        let data = try JSONSerialization.data(withJSONObject: ["id": "123"], options: [])
        let object = try JSONDecoder().decode(CodableUser.self, from: data)
        let user: CodableUser = .init(id: "123")
        XCTAssertEqual(object, user)
    }
}
