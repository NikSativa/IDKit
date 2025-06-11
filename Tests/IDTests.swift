import Foundation
import SpryKit
import XCTest
@testable import IDKit

final class IDTests: XCTestCase {
    private struct IDRepresentableUser: IDRepresentable, Hashable {
        let namedId: TypedID<Self>
    }

    private struct NamedUser: IDContract, Hashable {
        let id: TypedID<Self>
        let name: String
    }

    func test_equality() {
        let user1 = IDRepresentableUser(namedId: "id 1")
        let user2 = IDRepresentableUser(namedId: "id 1")
        XCTAssertEqual(user1, user2)

        let users = Set([user1, user2])
        XCTAssertEqual(users.count, 1)

        let ids = Set([user1.namedId, user2.namedId])
        XCTAssertEqual(ids.count, 1)
    }

    func test_not_equality() {
        let user1 = IDRepresentableUser(namedId: "id 1")
        let user2 = IDRepresentableUser(namedId: "id 2")
        XCTAssertNotEqual(user1, user2)

        let users = Set([user1, user2])
        XCTAssertEqual(users.count, 2)

        let ids = Set([user1.namedId, user2.namedId])
        XCTAssertEqual(ids.count, 2)
    }

    func test_named_equality() {
        let user1 = NamedUser(id: "id 1", name: "user 1")
        let user2 = NamedUser(id: "id 1", name: "user 2")
        XCTAssertNotEqual(user1, user2)
        XCTAssertEqual(user1.id, user2.id)

        let users = Set([user1, user2])
        XCTAssertEqual(users.count, 2)

        let ids = Set([user1.id, user2.id])
        XCTAssertEqual(ids.count, 1)
    }

    func test_named_not_equality() {
        let user1 = NamedUser(id: "id 1", name: "user 1")
        let user2 = NamedUser(id: "id 2", name: "user 2")
        XCTAssertNotEqual(user1, user2)
        XCTAssertNotEqual(user1.id, user2.id)

        let users = Set([user1, user2])
        XCTAssertEqual(users.count, 2)

        let ids = Set([user1.id, user2.id])
        XCTAssertEqual(ids.count, 2)
    }

    func test_named_full_equality() {
        let user1 = NamedUser(id: "id 1", name: "user 1")
        let user2 = NamedUser(id: "id 1", name: "user 1")
        XCTAssertEqual(user1, user2)
        XCTAssertEqual(user1.id, user2.id)

        let users = Set([user1, user2])
        XCTAssertEqual(users.count, 1)

        let ids = Set([user1.id, user2.id])
        XCTAssertEqual(ids.count, 1)
    }

    func test_sequence_extension() {
        let user1 = NamedUser(id: "id 1", name: "user 1")
        let user2 = NamedUser(id: "id 2", name: "user 2")
        let user3 = NamedUser(id: "id 3", name: "user 3")
        let users = [user1, user2]

        XCTAssertTrue(users.contains(idContract: user1))
        XCTAssertTrue(users.contains(idContract: user2))
        XCTAssertFalse(users.contains(idContract: user3))

        XCTAssertTrue(users.contains(id: user1.id))
        XCTAssertTrue(users.contains(id: user2.id))
        XCTAssertFalse(users.contains(id: user3.id))

        XCTAssertEqual(users.first(with: "id 1"), user1)
        XCTAssertEqual(users.first(with: user1.id), user1)
        XCTAssertEqual(users.first(with: user2.id), user2)
        XCTAssertNil(users.first(with: user3.id))
    }
}
