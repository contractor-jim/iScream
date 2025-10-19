//
//  UserServiceTests.swift
//  iScream
//
//  Created by James Woodbridge on 12/09/2025.
//

@testable import iScream
import Testing

struct UserServiceTests {

    @Test("POSITIVE - User service init") func testUserServiceInit() async throws {
        _ = DefaultUserService(supabaseService: MockSupaBaseService())
        #expect(DefaultUserService.modelContext != nil)
        #expect(DefaultUserService.didLoad == true)
    }

    @Test("POSITIVE - User service should return the parent user") func testValidUserReturned() async throws {
        let service = DefaultUserService(supabaseService: MockSupaBaseService())
        // Update from the mocks
        guard let user = try await service.getUser() else {
            fatalError("No user found")
        }

        // Test data points
        #expect(user.dataPoints.count == 0)
        #expect(user.name == "Daddy")
        #expect(user.iceCreamPoints == 0)
        #expect(user.negativeIceCreamPoints == 0)
    }

    // TODO: Need to write tests for pulling child user when we have mocked end points
}
