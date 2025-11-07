//
//  SupabaseService+User.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

import Foundation

extension SupaBaseService {
    func getLoggedInUserId() async throws -> UUID? {
        return try await client?.auth.user().id
    }

    func registerUser(email: String, password: String, nickname: String) async throws -> UUID? {
        let response = try await client?.auth.signUp(
          email: email,
          password: password,
          data: ["display_name": .string(nickname)]
        )

        return response!.user.id
    }

    func loginUser(email: String, password: String) async throws -> UUID {
        let response = try await client?.auth.signIn(
            email: email,
            password: password
        )

        return response!.user.id
    }

    func insertProfile(profile: Profile) async throws {
        try await insert(table: "user_profile", object: profile)
    }

    func fetchProfile(userId: UUID) async throws -> Profile? {
        return try await function(functionName: "get_profile",
                                  params: ["auth_id": userId],
                                  object: Profile.self)[0]
    }
}
