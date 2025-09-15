//
//  MockBounty.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream

extension Bounty {
    static var threeCorrectCompletedBounties: [Bounty] {
        [
            .init(title: "Test1", points: 1, completed: true),
            .init(title: "Test2", points: 2, completed: false),
            .init(title: "Test3", points: 3, completed: true)
        ]
    }

    static var threeCorrectIncompleteBounties: [Bounty] {
        [
            .init(title: "Test1", points: 1, completed: true),
            .init(title: "Test2", points: 2, completed: false),
            .init(title: "Test3", points: 3, completed: true)
        ]
    }
}
