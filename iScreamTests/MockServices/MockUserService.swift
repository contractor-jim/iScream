//
//  MockUserService.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Foundation

enum TestError: Error, Equatable {
    case signupError(String)
    case loginError(String)
}

class MockUserService: GenericService, UserService {
    func registerUser(email: String, password: String, nickname: String) async throws -> UUID {
        return UUID()
    }

    func loginUser(email: String, password: String) async throws -> UUID {
        return UUID()
    }

    func insertProfile(profile: iScream.Profile) async throws {

    }

    func fetchProfile(userId: UUID) async throws -> iScream.Profile? {
        return nil
    }

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
            throw TestError.signupError("Errr")
        }
    }

    func loginUser(email: String, password: String) async throws {
        if shouldFailLogin {
            throw TestError.loginError("Errr")
        }
    }
}

extension MockUserService: Equatable {
    static func == (lhs: MockUserService, rhs: MockUserService) -> Bool {
        lhs.mockUser == rhs.mockUser
    }
}
