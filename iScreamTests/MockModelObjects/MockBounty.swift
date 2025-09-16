//
//  MockBounty.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Foundation

extension Bounty {
    static var threeCorrectCompletedBounties: [Bounty] {
        [
            .init(id: UUID(), title: "Test1", points: 1, completed: true, user: User.mockUser),
            .init(id: UUID(), title: "Test2", points: 2, completed: false, user: User.mockUser),
            .init(id: UUID(), title: "Test3", points: 3, completed: true, user: User.mockUser)
        ]
    }

    static var threeCorrectIncompleteBounties: [Bounty] {
        [
            .init(id: UUID(), title: "Test1", points: 1, completed: true, user: User.mockUser),
            .init(id: UUID(), title: "Test2", points: 2, completed: false, user: User.mockUser),
            .init(id: UUID(), title: "Test3", points: 3, completed: true, user: User.mockUser)
        ]
    }
}
