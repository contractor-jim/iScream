//
//  UserErrorTests.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

@testable import iScream
import Testing
import Foundation

struct UserErrorTests {
    @Test("POSITIVE - User Error - Correct messages") func testInitAppServiceBuilder() throws {

        #expect(UserError.userServiceNotFound.description == "User service not found. Dev Error")
        #expect(UserError.loggedInUserNotFound.description == "User not logged in. Please login again.")
        #expect(UserError.registrationFailed.description == "User registration failed. Please try again")
        #expect(UserError.loginFailed.description == "Login failed. Please try again.")
        #expect(UserError.createProfileFailed.description == "Failed to create the users profile. Please try again.")
        #expect(UserError.fetchUserProfileFailed.description == "Failed to fetch user profile. Please try again.")

        #expect(UserError.userServiceNotFound.localizedDescription == "User service not found. Dev Error")
        #expect(UserError.loggedInUserNotFound.localizedDescription == "User not logged in. Please login again.")
        #expect(UserError.registrationFailed.localizedDescription == "User registration failed. Please try again")
        #expect(UserError.loginFailed.localizedDescription == "Login failed. Please try again.")
        #expect(UserError.createProfileFailed.localizedDescription == "Failed to create the users profile. Please try again.")
        #expect(UserError.fetchUserProfileFailed.localizedDescription == "Failed to fetch user profile. Please try again.")
    }
}
