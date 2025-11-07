//
//  MockSupabaseService+User.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

@testable import iScream
import Foundation

extension MockSupaBaseService {
    func getLoggedInUserId() async throws -> UUID? {
        if let loggedInUserIdError {
            throw loggedInUserIdError
        }

        return mockedUUID
    }

    func registerUser(email: String, password: String, nickname: String) async throws -> UUID? {
        if let registerUserIdError {
            throw registerUserIdError
        }

        return mockedUUID
    }

    func loginUser(email: String, password: String) async throws -> UUID {

        if email == "fail@fail.fail" {
            throw TestError.loginError("Test")
        }

        return mockedUUID!
    }

    func insertProfile(profile: Profile) async throws {
        if let registerProfileError {
            throw registerProfileError
        }
    }

    func fetchProfile(userId: UUID) async throws -> Profile? {
        if let fetchProfileError {
            throw fetchProfileError
        }

        return mockProfile
    }
}
