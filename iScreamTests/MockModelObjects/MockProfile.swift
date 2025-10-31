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
                              bounties: [])

        return profile
    }()
}
