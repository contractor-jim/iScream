//
//  BountyTests.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

@testable import iScream
import Testing
import Foundation

struct BountyTests {
    let id = UUID()
    let parentId = UUID()
    let parentAuthId = UUID()
    let bounty: Bounty

    init() {
        bounty = Bounty(id: id,
                        parentId: parentId,
                        title: "TEST",
                        points: 100,
                        completed: false,
                        pendingComplete: true,
                        rarity: .bronze)
    }

    @Test("POSITIVE - Bounty -  init") func testInitBounty() async throws {
        #expect(bounty.id == id)
        #expect(bounty.parentId == parentId)
        #expect(bounty.title == "TEST")
        #expect(bounty.points == 100)
        #expect(bounty.completed == false)
        #expect(bounty.pendingComplete == true)
        #expect(bounty.rarity == .bronze)

        #expect(bounty == Bounty(id: id,
                                 parentId: parentId,
                                 title: "TEST",
                                 points: 100,
                                 completed: false,
                                 pendingComplete: true,
                                 rarity: .bronze))
    }

    @Test("POSITIVE - Bounty - CodingKeys ") func testBounty_CodingKeys() async throws {
        #expect(Bounty.CodingKeys.id.rawValue == "id")
        #expect(Bounty.CodingKeys.parentId.rawValue == "parent_id")
        #expect(Bounty.CodingKeys.title.rawValue == "title")
        #expect(Bounty.CodingKeys.points.rawValue == "points")
        #expect(Bounty.CodingKeys.completed.rawValue == "completed")
        #expect(Bounty.CodingKeys.pendingComplete.rawValue == "pending_complete")
        #expect(Bounty.CodingKeys.rarity.rawValue == "rarity")
    }

}
