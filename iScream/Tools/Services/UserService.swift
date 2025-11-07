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

    func getLoggedInUserId() async throws -> UUID? {
        do {
            return try await supabaseService.getLoggedInUserId()
        } catch {
            throw UserError.loggedInUserNotFound
        }
    }

    func registerUser(email: String, password: String, nickname: String) async throws -> UUID {
        do {
            return try await supabaseService.registerUser(email: email, password: password, nickname: nickname)!
        } catch {
            throw UserError.registrationFailed
        }
    }

    func loginUser(email: String, password: String) async throws -> UUID {
        do {
            return try await supabaseService.loginUser(email: email, password: password)
        } catch {
            throw UserError.loginFailed
        }
    }

    func insertProfile(profile: Profile) async throws {
        do {
            try await supabaseService.insertProfile(profile: profile)
        } catch {
            throw UserError.createProfileFailed
        }
    }

    func fetchProfile() async throws -> Profile? {
        guard let userId = try await getLoggedInUserId() else {
            throw UserError.loggedInUserNotFound
        }

        do {
            return try await supabaseService.fetchProfile(userId: userId)
        } catch {
            throw UserError.fetchUserProfileFailed
        }
    }
}
