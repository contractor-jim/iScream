//
//  ProfileTests.swift
//  iScream
//
//  Created by James Woodbridge on 23/10/2025.
//
@testable import iScream
import Testing
import Foundation

struct ProfileTests {

    let parentId = UUID()
    let parentAuthId = UUID()
    let parentProfile: Profile

    init() {
        parentProfile = Profile(userName: "Test",
                                type: "parent",
                                points: 0,
                                negativePoints: 0,
                                parentId: nil,
                                authId: parentAuthId,
                                children: [])

    }

    @Test("POSITIVE - user profile parent init") func testInitParentUserProfile() async throws {

        #expect(parentProfile.id == nil)
        #expect(parentProfile.userName == "Test")
        #expect(parentProfile.type == "parent")
        #expect(parentProfile.points == 0)
        #expect(parentProfile.negativePoints == 0)
        #expect(parentProfile.parentId == nil)
        #expect(parentProfile.authId == parentAuthId)
    }
}
