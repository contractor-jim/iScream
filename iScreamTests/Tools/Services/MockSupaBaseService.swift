//
//  MockSupaBaseService.swift
//  iScream
//
//  Created by James Woodbridge on 20/10/2025.
//

@testable import iScream
import Supabase
import Foundation

class MockSupaBaseService: SupaBaseService {

    var client: Supabase.SupabaseClient?
    var mockedUUID: UUID?
    var loggedInUserIdError: Error?
    var registerUserIdError: Error?
    var registerProfileError: Error?
    var mockProfile: Profile?
    var fetchProfileError: Error?

    func fetch<T>(table: String, eq: [String: any PostgrestFilterValue], type: T.Type) async throws -> T? where T: Decodable, T: Encodable {
        return nil
    }

    func insert<T>(table: String, object: T) async throws where T: Decodable, T: Encodable { }

    func fetchArr<T>(table: String, eq: [String: any PostgREST.PostgrestFilterValue], type: T.Type) async throws -> [T] where T: Decodable, T: Encodable {
        return []
    }

    func function<T>(functionName: String, params: [String: some Encodable & Sendable], object: T.Type) async throws -> [T] where T: Decodable, T: Encodable {
        return []
    }

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
