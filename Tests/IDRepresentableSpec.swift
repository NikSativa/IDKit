import Foundation
import Nimble
import NSpry
import Quick

@testable import NAnyID
@testable import NAnyIDTestHelpers

final class IDRepresentableSpec: QuickSpec {
    private struct CodableUser: Identifying, Equatable, Codable {
        let id: ID<Self>
    }

    private struct EncodableUser: Identifying, Equatable, Encodable {
        let id: ID<Self>
    }

    private struct DecodableUser: Identifying, Equatable, Decodable {
        typealias RawIdentifier = Int
        let id: ID<Self>
    }

    override func spec() {
        describe("IDRepresentable") {
            context("Codable") {
                var user: CodableUser!
                var userJSON: [String: String]!

                beforeEach {
                    user = .init(id: .init("123"))
                    userJSON = ["id": "123"]
                }

                it("should support Encodable") {
                    expect {
                        let data = try JSONEncoder().encode(user)
                        let object = try JSONSerialization.jsonObject(with: data, options: [])
                        return object as? [String: String]
                    } == userJSON
                }

                it("should support Decodable") {
                    expect {
                        let data = try JSONSerialization.data(withJSONObject: userJSON.unsafelyUnwrapped, options: [])
                        let object = try JSONDecoder().decode(CodableUser.self, from: data)
                        return object
                    } == user
                }
            }

            context("Decodable") {
                var user: DecodableUser!
                var userJSON: [String: Int]!

                beforeEach {
                    user = .init(id: .init(rawValue: 123))
                    userJSON = ["id": 123]
                }

                it("should support Decodable") {
                    expect {
                        let data = try JSONSerialization.data(withJSONObject: userJSON.unsafelyUnwrapped, options: [])
                        let object = try JSONDecoder().decode(DecodableUser.self, from: data)
                        return object
                    } == user
                }

                it("should support Comparable") {
                    expect(user.id == 123) == true
                    expect(user.id == 123) == true
                }
            }

            context("Encodable") {
                var user: EncodableUser!
                var userJSON: [String: String]!

                beforeEach {
                    user = .init(id: .init("123"))
                    userJSON = ["id": "123"]
                }

                it("should support Encodable") {
                    expect {
                        let data = try JSONEncoder().encode(user)
                        let object = try JSONSerialization.jsonObject(with: data, options: [])
                        return object as? [String: String]
                    } == userJSON
                }

                it("should support Comparable") {
                    expect(user.id) == ID("123")
                    expect(user.id) == ID("123")
                }
            }
        }
    }
}
