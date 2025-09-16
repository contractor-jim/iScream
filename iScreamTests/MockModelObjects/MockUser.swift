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

        let formatter = ISO8601DateFormatter()

        user.dataPoints = [PointData(id: UUID(),
                                     month: formatter.date(from: "2025-01-01T00:00:00Z")!,
                                     points: 5, user:
                                        user),
                           PointData(id: UUID(),
                                     month: formatter.date(from: "2025-01-01T00:00:00Z")!,
                                     points: 11,
                                     user: user)]

        return user
    }
}
