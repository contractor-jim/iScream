//
//  MockUser.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Foundation

extension User {
    static var mockUser: User {
        let user = User(id: UUID(),
             dataPoints: [],
             bounties: Bounty.threeCorrectIncompleteBounties,
             name: "Test",
             iceCreamPoints: 1000,
             negativeIceCreamPoints: 50,
             type: "child")

        user.dataPoints = [PointData(id: UUID(), month: "Jan", points: 5, user: user),
                           PointData(id: UUID(), month: "Feb", points: 11, user: user)]

        return user
    }
}
