//
//  MockUserService.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Foundation

enum TestSignupError: Error {
    case signupError(String)
    case loginError(String)
}

class MockUserService: GenericService, UserService {

    var mockUser: User?
    var shouldFailSignup: Bool = false
    var shouldFailLogin: Bool = false

    func getUser() async throws -> iScream.User? {
        return mockUser ?? User(id: UUID(),
                                dataPoints: [],
                                bounties: [],
                                name: "",
                                iceCreamPoints: 0,
                                negativeIceCreamPoints: 0,
                                type: "parent")
    }

    func registerUser(email: String, password: String, nickname: String) async throws {
        if shouldFailSignup {
            throw TestSignupError.signupError("Errr")
        }
    }

    func loginUser(email: String, password: String) async throws {
        if shouldFailLogin {
            throw TestSignupError.loginError("Errr")
        }
    }
}

extension MockUserService: Equatable {
    static func == (lhs: MockUserService, rhs: MockUserService) -> Bool {
        lhs.mockUser == rhs.mockUser
    }
}
