//
//  MockProfile.swift
//  iScream
//
//  Created by James Woodbridge on 31/10/2025.
//

@testable import iScream
import Foundation

extension Profile {
    static var mockProfile: Profile = {
        let profile = Profile(userName: "test",
                              type: .parent,
                              points: 100,
                              negativePoints: 50,
                              parentId: nil,
                              authId: UUID(),
                              children: [],
                              managedBounties: [],
                              bounties: [Bounty(id: UUID(),
                                                parentId: UUID(),
                                                title: "Test",
                                                points: 10,
                                                completed: false,
                                                profile: nil),
                                         Bounty(id: UUID(),
                                                           parentId: UUID(),
                                                           title: "Test",
                                                           points: 10,
                                                           completed: true,
                                                           profile: nil)],
                              dataPoints: [],
                              achievements: [])

        return profile
    }()

    static var mockChildProfile: Profile = {
        let profile = Profile(userName: "test",
                              type: .child,
                              points: 100,
                              negativePoints: 50,
                              parentId: nil,
                              authId: UUID(),
                              children: [],
                              managedBounties: [],
                              bounties: [],
                              dataPoints: [],
                              achievements: [])

        return profile
    }()
}
