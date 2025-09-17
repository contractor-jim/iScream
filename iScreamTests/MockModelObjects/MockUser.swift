//
//  MockUser.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Foundation

extension User {
    static var mockUser: User = {
        let user = User(id: UUID(),
             dataPoints: [],
             bounties: [],
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

        user.bounties = [Bounty(id: UUID(), title: "Test1", points: 1, completed: true, user: user),
                         Bounty(id: UUID(), title: "Test2", points: 2, completed: true, user: user),
                         Bounty(id: UUID(), title: "Test3", points: 3, completed: true, user: user),
                         Bounty(id: UUID(), title: "Test1", points: 1, completed: false, user: user),
                         Bounty(id: UUID(), title: "Test2", points: 2, completed: false, user: user),
                         Bounty(id: UUID(), title: "Test3", points: 3, completed: false, user: user)]

        return user
    }()
}
