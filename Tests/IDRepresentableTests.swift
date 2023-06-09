import Foundation
import NSpry
import XCTest

@testable import NAnyID
@testable import NAnyIDTestHelpers

final class IDRepresentableTests: XCTestCase {
    private struct CodableUser: Identifying, Equatable, Codable {
        let id: ID<Self>
    }

    func test_encodable() throws {
        let user: CodableUser = .init(id: .init("123"))
        let data = try JSONEncoder().encode(user)
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        XCTAssertEqual(object as? [String: String], ["id": "123"])
    }

    func test_decodable() throws {
        let data = try JSONSerialization.data(withJSONObject: ["id": "123"], options: [])
        let object = try JSONDecoder().decode(CodableUser.self, from: data)
        let user: CodableUser = .init(id: .init("123"))
        XCTAssertEqual(object, user)
    }
}
