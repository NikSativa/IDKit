import Foundation
import Nimble
import NSpry
import Quick

@testable import AnyID
@testable import AnyIDTestHelpers

final class IDSpec: QuickSpec {
    private struct IDRepresentableUser: IDRepresentable, Hashable {
        let namedId: ID<Self>
    }

    private struct NamedUser: Identifying, Hashable {
        let id: ID<Self>
        let name: String
    }

    override func spec() {
        describe("ID") {
            describe("IDRepresentableUser") {
                context("when users are equal") {
                    var user1: IDRepresentableUser!
                    var user2: IDRepresentableUser!

                    beforeEach {
                        user1 = IDRepresentableUser(namedId: .init("id 1"))
                        user2 = IDRepresentableUser(namedId: .init("id 1"))
                    }

                    it("should support equality") {
                        expect(user1) == user2
                        expect(user1.namedId) == user2.namedId
                    }

                    it("should support hashing") {
                        let users = Set([user1, user2])
                        expect(users).to(haveCount(1))

                        let ids = Set([user1.namedId, user2.namedId])
                        expect(ids).to(haveCount(1))
                    }
                }

                context("when users are not equal") {
                    var user1: IDRepresentableUser!
                    var user2: IDRepresentableUser!

                    beforeEach {
                        user1 = .init(namedId: .init("id 1"))
                        user2 = .init(namedId: .init("id 2"))
                    }

                    it("should support equality") {
                        expect(user1) != user2
                        expect(user1.namedId) != user2.namedId
                    }

                    it("should support hashing") {
                        let users = Set([user1, user2])
                        expect(users).to(haveCount(2))

                        let ids = Set([user1.namedId, user2.namedId])
                        expect(ids).to(haveCount(2))
                    }
                }
            }

            describe("NamedUser") {
                context("when users are equal by id") {
                    var user1: NamedUser!
                    var user2: NamedUser!

                    beforeEach {
                        user1 = .init(id: .init("id 1"), name: "user 1")
                        user2 = .init(id: .init("id 1"), name: "user 2")
                    }

                    it("should support equality") {
                        expect(user1) != user2
                        expect(user1.id) == user2.id
                    }

                    it("should support hashing") {
                        let users = Set([user1, user2])
                        expect(users).to(haveCount(2))

                        let ids = Set([user1.id, user2.id])
                        expect(ids).to(haveCount(1))
                    }
                }

                context("when users are not completely equal") {
                    var user1: NamedUser!
                    var user2: NamedUser!

                    beforeEach {
                        user1 = .init(id: .init("id 1"), name: "user 1")
                        user2 = .init(id: .init("id 2"), name: "user 2")
                    }

                    it("should support equality") {
                        expect(user1) != user2
                        expect(user1.id) != user2.id
                    }

                    it("should support hashing") {
                        let users = Set([user1, user2])
                        expect(users).to(haveCount(2))

                        let ids = Set([user1.id, user2.id])
                        expect(ids).to(haveCount(2))
                    }
                }

                context("when users are completely equal") {
                    var user1: NamedUser!
                    var user2: NamedUser!

                    beforeEach {
                        user1 = .init(id: .init("id 1"), name: "user 1")
                        user2 = .init(id: .init("id 1"), name: "user 2")
                    }

                    it("should support equality") {
                        expect(user1) != user2
                        expect(user1.id) == user2.id
                    }

                    it("should support hashing") {
                        let users = Set([user1, user2])
                        expect(users).to(haveCount(2))

                        let ids = Set([user1.id, user2.id])
                        expect(ids).to(haveCount(1))
                    }
                }
            }

            describe("sequence extension") {
                var users: [NamedUser]!
                var user1: NamedUser!
                var user2: NamedUser!
                var user3: NamedUser!

                beforeEach {
                    user1 = .init(id: .init("id 1"), name: "user 1")
                    user2 = .init(id: .init("id 2"), name: "user 2")
                    user3 = .init(id: .init("id 3"), name: "user 3")
                    users = [user1.unsafelyUnwrapped, user2.unsafelyUnwrapped]
                }

                describe("contains element") {
                    it("should return corresponding value") {
                        expect(users.contains(identifyingElement: user1)) == true
                        expect(users.contains(identifyingElement: user2)) == true
                        expect(users.contains(identifyingElement: user3)) == false
                    }
                }

                describe("contains id") {
                    it("should return corresponding value") {
                        expect(users.contains(id: user1.id)) == true
                        expect(users.contains(id: user2.id)) == true
                        expect(users.contains(id: user3.id)) == false
                    }
                }

                describe("first with id") {
                    it("should return corresponding value") {
                        expect(users.first(with: .init("id 1"))) == user1
                        expect(users.first(with: user1.id)) == user1
                        expect(users.first(with: user2.id)) == user2
                        expect(users.first(with: user3.id)).to(beNil())
                    }
                }
            }
        }
    }
}
