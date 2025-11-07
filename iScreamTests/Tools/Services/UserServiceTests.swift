//
//  UserServiceTests.swift
//  iScream
//
//  Created by James Woodbridge on 12/09/2025.
//

@testable import iScream
import Testing
import Foundation

struct UserServiceTests {

    @Test("POSITIVE - User service init") func testUserServiceInit() async throws {
        _ = DefaultUserService(supabaseService: MockSupaBaseService())
        #expect(DefaultUserService.modelContext != nil)
        #expect(DefaultUserService.didLoad == true)
    }

    @Test("POSITIVE - User service should return a user id if the user is logged in") func testFetchUserId_ReturnsId() async throws {
        let supabaseService = MockSupaBaseService()
        let userId = UUID()
        supabaseService.mockedUUID = userId
        let userService = DefaultUserService(supabaseService: supabaseService)

        let response = try await userService.getLoggedInUserId()
        #expect(response != nil)
        #expect(response == userId)
    }

    @Test("NEGATIVE - User service should not return a user id if the user is not logged in") func testFetchUserId_NoId() async throws {
        let supabaseService = MockSupaBaseService()
        supabaseService.mockedUUID = nil
        let userService = DefaultUserService(supabaseService: supabaseService)

        let response = try await userService.getLoggedInUserId()
        #expect(response == nil)
    }

    @Test("NEGATIVE - User service should throw error if user id retrival fails") func testFetchUserId_Throws() async throws {
        let supabaseService = MockSupaBaseService()
        supabaseService.loggedInUserIdError = TestError.loginError("Test")
        let userService = DefaultUserService(supabaseService: supabaseService)

        await #expect(throws: (UserError.loggedInUserNotFound).self) {
            _ = try await userService.getLoggedInUserId()
        }
    }

    @Test("POSITIVE - User service should register a new user") func testRegisterUser_returnsUserId() async throws {
        let supabaseService = MockSupaBaseService()
        let userId = UUID()
        supabaseService.mockedUUID = userId
        let userService = DefaultUserService(supabaseService: supabaseService)

        let response = try await userService.registerUser(email: "test@test.test", password: "ABcd1234?", nickname: "McTest")
        #expect(response == userId)
    }

    @Test("NEGATIVE - User service should reguster a new user") func testRegisterUser_throws() async throws {
        let supabaseService = MockSupaBaseService()
        supabaseService.registerUserIdError = TestError.loginError("Test")
        let userService = DefaultUserService(supabaseService: supabaseService)

        await #expect(throws: (UserError.registrationFailed).self) {
            _ = try await userService.registerUser(email: "test@test.test", password: "ABcd1234?", nickname: "McTest")
        }
    }

    @Test("POSITIVE - Login in user") func testLoginUser_returnsUserId() async throws {
        let supabaseService = MockSupaBaseService()
        let userId = UUID()
        supabaseService.mockedUUID = userId
        let userService = DefaultUserService(supabaseService: supabaseService)

        let response = try await userService.loginUser(email: "test@test.test", password: "ABcd124?")
        #expect(response == userId)
    }

    @Test("POSITIVE - Login in user should throw") func testLoginUserThrows() async throws {
        let supabaseService = MockSupaBaseService()
        let userService = DefaultUserService(supabaseService: supabaseService)

        await #expect(throws: (UserError.loginFailed).self) {
            _ = try await userService.loginUser(email: "fail@fail.fail", password: "ABcd124?")
        }
    }

    @Test("POSITIVE - Create user profile") func registerUser_doesNotThrowError() async throws {
        let supabaseService = MockSupaBaseService()
        let userService = DefaultUserService(supabaseService: supabaseService)

        await #expect(throws: Never.self) {
            _ = try await userService.insertProfile(profile: Profile.mockProfile)
        }
    }

    @Test("NEGATIVE - Create user profile fails") func registerUser_throwsError() async throws {
        let supabaseService = MockSupaBaseService()
        supabaseService.registerProfileError = TestError.loginError("Test")
        let userService = DefaultUserService(supabaseService: supabaseService)

        await #expect(throws: (UserError.createProfileFailed).self) {
            _ = try await userService.insertProfile(profile: Profile.mockProfile)
        }
    }

    @Test("POSITIVE - User service should return the parent user") func testValid_ParentUserReturned() async throws {
        let supabaseService = MockSupaBaseService()
        let mockProfile = Profile.mockProfile
        supabaseService.mockProfile = mockProfile
        supabaseService.mockedUUID = UUID()
        let userService = DefaultUserService(supabaseService: supabaseService)

        // Update from the mocks
        guard let profile = try await userService.fetchProfile() else {
            fatalError("No user found")
        }

        #expect(profile == mockProfile)
    }

    @Test("POSITIVE - User service should return the child user") func testValid_ChildUserReturned() async throws {
        let supabaseService = MockSupaBaseService()
        let mockProfile = Profile.mockChildProfile
        supabaseService.mockProfile = mockProfile
        supabaseService.mockedUUID = UUID()
        let userService = DefaultUserService(supabaseService: supabaseService)

        // Update from the mocks
        guard let profile = try await userService.fetchProfile() else {
            fatalError("No user found")
        }

        #expect(profile == mockProfile)
        #expect(profile.type == .child)
    }

    @Test("NEGATIVE - User service throws error when user ID is missing") func testMissingUserId_Throws() async throws {
        let supabaseService = MockSupaBaseService()
        let mockProfile = Profile.mockProfile
        supabaseService.mockProfile = mockProfile
        supabaseService.mockedUUID = nil
        let userService = DefaultUserService(supabaseService: supabaseService)

        await #expect(throws: (UserError.loggedInUserNotFound).self) {
            _ = try await userService.fetchProfile()
        }
    }

    @Test("NEGATIVE - User service throws error when profile fails") func testProfileFails_Throws() async throws {
        let supabaseService = MockSupaBaseService()
        let mockProfile = Profile.mockProfile
        supabaseService.mockProfile = mockProfile
        supabaseService.mockedUUID = UUID()
        supabaseService.fetchProfileError = TestError.loginError("Test")
        let userService = DefaultUserService(supabaseService: supabaseService)

        await #expect(throws: (UserError.fetchUserProfileFailed).self) {
            _ = try await userService.fetchProfile()
        }
    }
}
