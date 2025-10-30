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

    var mockUser: User?
    var shouldFailSignup: Bool = false
    var shouldFailLogin: Bool = false

    var mockProfile: Profile?
    var mockUserID = UUID()

    func registerUser(email: String, password: String, nickname: String) async throws -> UUID {
        if shouldFailSignup {
            throw TestError.signupError("Errr")
        }

        return mockUserID
    }

    func loginUser(email: String, password: String) async throws -> UUID {
        if shouldFailLogin {
            throw TestError.loginError("Errr")
        }

        return mockUserID
    }

    func insertProfile(profile: Profile) async throws {
        mockProfile = profile
    }

    func fetchProfile() async throws -> iScream.Profile? {
        return mockProfile
    }

    func getLoggedInUserId() async throws -> UUID? {
        return UUID()
    }
}

extension MockUserService: Equatable {
    static func == (lhs: MockUserService, rhs: MockUserService) -> Bool {
        lhs.mockUser == rhs.mockUser
    }
}
