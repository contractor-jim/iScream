//
//  LoginErrorTests.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

@testable import iScream
import Testing
import Foundation

struct LoginErrorTests {
    @Test("POSITIVE - Login Error - Correct messages") func testInitAppServiceBuilder() throws {
        #expect(LoginError.failedToLoadProfile.description == "Failed to load the user profile")
        #expect(LoginError.loginDetailsIncorrect.description == "Username or password incorrect")
        #expect(LoginError.failedToLoadProfile.localizedDescription == "Failed to load the user profile")
        #expect(LoginError.loginDetailsIncorrect.localizedDescription == "Username or password incorrect")
    }
}
