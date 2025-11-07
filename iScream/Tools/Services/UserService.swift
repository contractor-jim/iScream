//
//  UserService.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import Foundation
import SwiftData

protocol UserService {
    func getLoggedInUserId() async throws -> UUID?
    func registerUser(email: String, password: String, nickname: String) async throws -> UUID
    func loginUser(email: String, password: String) async throws -> UUID
    func insertProfile(profile: Profile) async throws
    func fetchProfile() async throws -> Profile?
}

class DefaultUserService: GenericService, UserService {

    static var modelContext: ModelContext?
    static var didLoad = false
    let supabaseService: SupaBaseService

    init(supabaseService: SupaBaseService) {

        self.supabaseService = supabaseService

        super.init()

        if !DefaultUserService.didLoad {
            // Mocked data for now till we get the database in place
            guard let modelContext = DefaultUserService.modelContext else {
                fatalError("Model context not set on the UserService")
            }

            do {
                try modelContext.delete(model: Profile.self)
            } catch {
                fatalError("Failed to clear the cache \(error)")
            }

            DefaultUserService.didLoad = true
        }
    }

    /*
     WE ARE CALLING ACTUALL FUNCTIONS FROM HERE
     */
    func getLoggedInUserId() async throws -> UUID? {
        return try await supabaseService.client?.auth.user().id
    }

    func registerUser(email: String, password: String, nickname: String) async throws -> UUID {
        let response = try await supabaseService.client?.auth.signUp(
          email: email,
          password: password,
          data: ["display_name": .string(nickname)]
        )

        // TODO: Test that a UUID exists and the response was succesfull
        return response!.user.id
    }

    func loginUser(email: String, password: String) async throws -> UUID {
        let response = try await supabaseService.client?.auth.signIn(
            email: email,
            password: password
        )

        // TODO: Test that a UUID exists and the response was succesfull
        return response!.user.id
    }

    func insertProfile(profile: Profile) async throws {
        try await supabaseService.insert(table: "user_profile", object: profile)
    }

    func fetchProfile() async throws -> Profile? {
        // TODO: need to throw error if there is no valid user service
        guard let userId = try await getLoggedInUserId() else {
            // TODO: Add error handeling here
            return nil
        }

        return try await supabaseService.function(functionName: "get_profile",
                                                   params: ["auth_id": userId],
                                                   object: Profile.self)[0]
    }
}
