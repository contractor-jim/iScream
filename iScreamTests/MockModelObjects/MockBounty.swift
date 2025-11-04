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
            .init(id: UUID(), parentId: UUID(), title: "Test1", points: 1, completed: true, profile: [Profile.mockProfile]),
            .init(id: UUID(), parentId: UUID(), title: "Test2", points: 2, completed: true, profile: [Profile.mockProfile]),
            .init(id: UUID(), parentId: UUID(), title: "Test3", points: 3, completed: true, profile: [Profile.mockProfile])
        ]
    }

    static var threeCorrectIncompleteBounties: [Bounty] {
        [
            .init(id: UUID(), parentId: UUID(), title: "Test1", points: 1, completed: false, profile: [Profile.mockProfile]),
            .init(id: UUID(), parentId: UUID(), title: "Test2", points: 2, completed: false, profile: [Profile.mockProfile]),
            .init(id: UUID(), parentId: UUID(), title: "Test3", points: 3, completed: false, profile: [Profile.mockProfile])
        ]
    }
}
