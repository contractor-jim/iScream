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

    let id = UUID()
    let parentId = UUID()
    let parentAuthId = UUID()
    let parentProfile: Profile

    init() {
        parentProfile = Profile(id: id,
                                userName: "McTest",
                                type: .parent,
                                points: 1000,
                                negativePoints: -100,
                                parentId: parentId,
                                authId: parentAuthId,
                                children: [],
                                managedBounties: [],
                                bounties: [],
                                dataPoints: [],
                                achievements: [])
    }

    @Test("POSITIVE - user profile parent init") func testInitParentUserProfile() async throws {
        #expect(parentProfile.id == id)
        #expect(parentProfile.userName == "McTest")
        #expect(parentProfile.type == .parent)
        #expect(parentProfile.points == 1000)
        #expect(parentProfile.negativePoints == -100)
        #expect(parentProfile.parentId == parentId)
        #expect(parentProfile.authId == parentAuthId)
        #expect(parentProfile.children == [])
        #expect(parentProfile.managedBounties == [])
        #expect(parentProfile.bounties == [])
        #expect(parentProfile == Profile(id: id,
                                         userName: "McTest",
                                         type: .parent,
                                         points: 1000,
                                         negativePoints: -100,
                                         parentId: parentId,
                                         authId: parentAuthId,
                                         children: [],
                                         managedBounties: [],
                                         bounties: [],
                                         dataPoints: [],
                                         achievements: []))
    }

    @Test("POSITIVE - user profile coding keys") func testProfile_CodingKeys() async throws {
        #expect(Profile.CodingKeys.id.rawValue == "id")
        #expect(Profile.CodingKeys.userName.rawValue == "user_name")
        #expect(Profile.CodingKeys.type.rawValue == "type")
        #expect(Profile.CodingKeys.points.rawValue == "points")
        #expect(Profile.CodingKeys.negativePoints.rawValue == "negativePoints")
        #expect(Profile.CodingKeys.parentId.rawValue == "parent_id")
        #expect(Profile.CodingKeys.authId.rawValue == "auth_id")
        #expect(Profile.CodingKeys.children.rawValue == "children")
        #expect(Profile.CodingKeys.managedBounties.rawValue == "managed_bounties")
        #expect(Profile.CodingKeys.bounties.rawValue == "bounties")
    }
}
