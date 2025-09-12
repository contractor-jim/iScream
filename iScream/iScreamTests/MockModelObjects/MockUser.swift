//
//  MockUser.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream

extension User {
    static var mockUser: User {
        User(dataPoints: [IceCreamData(month: "Jan", points: 5),
                          IceCreamData(month: "Feb", points: 11)],
             openBounties: Bounty.threeCorrectIncompleteBounties,
             completedBounties: Bounty.threeCorrectCompletedBounties,
             name: "Test",
             iceCreamPoints: 1000,
             negativeIceCreamPoints: 50)
    }
}
