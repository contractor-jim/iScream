//
//  UserTests.swift
//  iScream
//
//  Created by James Woodbridge on 17/09/2025.
//

@testable import iScream
import Foundation
import Testing

struct UserTests {

    let parentUser: User
    let childUser: User
    let openBounty: Bounty
    let closedBounty: Bounty

    init() {
        let id = UUID()

        childUser = User(id: UUID(),
                         dataPoints: [],
                         bounties: [],
                         name: "Test",
                         iceCreamPoints: 1000,
                         negativeIceCreamPoints: -100,
                         type: "child",
                         children: [])

        let children = [childUser]

        parentUser = User(id: id,
                        dataPoints: [],
                        bounties: [],
                        name: "Test",
                        iceCreamPoints: 1000,
                        negativeIceCreamPoints: -100,
                        type: "parent",
                        children: children)

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 10, user: parentUser)]
        childUser.dataPoints = dataPoints

        openBounty = Bounty(id: UUID(), title: "TestFalse", points: 100, completed: false, user: parentUser)
        closedBounty = Bounty(id: UUID(), title: "TestTrue", points: 100, completed: true, user: parentUser)
        let bounties: [Bounty] = [openBounty, closedBounty]
        childUser.bounties = bounties
    }

    @Test("POSITIVE - child user init") func testInitChildUser() async throws {
        let id = UUID()

        let user = User(id: id,
                        dataPoints: [],
                        bounties: [],
                        name: "Test",
                        iceCreamPoints: 1000,
                        negativeIceCreamPoints: -100,
                        type: "child",
                        children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 10, user: user)]
        user.dataPoints = dataPoints

        let bounties: [Bounty] = [Bounty(id: UUID(), title: "TestTrue", points: 100, completed: true, user: user),
                                  Bounty(id: UUID(), title: "TestFalse", points: 100, completed: false, user: user)]
        user.bounties = bounties

        #expect(user.id == id)
        #expect(user.dataPoints == dataPoints)
        #expect(user.bounties == bounties)
        #expect(user.name == "Test")
        #expect(user.iceCreamPoints == 1000)
        #expect(user.negativeIceCreamPoints == -100)
        #expect(user.type == "child")
        #expect(user.children == [])
    }

    @Test("POSITIVE - parent user init") func testInitParentUser() async throws {
        let id = UUID()

        let children = [User(id: UUID(),
                        dataPoints: [],
                        bounties: [],
                        name: "Test",
                        iceCreamPoints: 1000,
                        negativeIceCreamPoints: -100,
                        type: "child",
                        children: [])]

        let user = User(id: id,
                        dataPoints: [],
                        bounties: [],
                        name: "Test",
                        iceCreamPoints: 1000,
                        negativeIceCreamPoints: -100,
                        type: "parent",
                        children: children)

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 10, user: user)]
        user.dataPoints = dataPoints

        let bounties: [Bounty] = [Bounty(id: UUID(), title: "TestTrue", points: 100, completed: true, user: user),
                                  Bounty(id: UUID(), title: "TestFalse", points: 100, completed: false, user: user)]
        user.bounties = bounties

        #expect(user.id == id)
        #expect(user.dataPoints == dataPoints)
        #expect(user.bounties == bounties)
        #expect(user.name == "Test")
        #expect(user.iceCreamPoints == 1000)
        #expect(user.negativeIceCreamPoints == -100)
        #expect(user.type == "parent")
        #expect(user.children == children)
    }

    @Test("POSITIVE - openBounties exist") func testChildBountiesOpen() async throws {
        #expect(childUser.openBounties.count == 1)
        #expect(childUser.openBounties[0] == openBounty)
    }

    @Test("POSITIVE - closedBounties exist") func testChildBountiesClosed() async throws {
        #expect(childUser.completedBounties.count == 1)
        #expect(childUser.completedBounties[0] == closedBounty)
    }

    @Test("POSITIVE - hasImproved true") func testChildhasImproved_Yes() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 10, user: user),
                                       PointData(id: UUID(), month: Date(), points: 16, user: user)]
        user.dataPoints = dataPoints
        #expect(user.hasImproved == true)
    }

    @Test("POSITIVE - hasImproved false") func testChildhasImproved_No() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 16, user: user),
                                       PointData(id: UUID(), month: Date(), points: 10, user: user)]
        user.dataPoints = dataPoints
        #expect(user.hasImproved == false)
    }

    @Test("POSITIVE - hasImproved false one entry") func testChildhasImproved_No_OneEntry() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 16, user: user)]
        user.dataPoints = dataPoints
        #expect(user.hasImproved == false)
    }

    @Test("POSITIVE - max") func testChildMax() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 16, user: user),
                                       PointData(id: UUID(), month: Date(), points: 10, user: user)]
        user.dataPoints = dataPoints
        #expect(user.max == 16)
    }

    @Test("POSITIVE - max one value") func testChildMax_OneValue() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 99, user: user)]
        user.dataPoints = dataPoints
        #expect(user.max == 99)
    }

    @Test("NEGATIVE - max no values") func testChildMax_NoValue() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = []
        user.dataPoints = dataPoints
        #expect(user.max == 0)
    }

    @Test("POSITIVE - aggregate negative score") func testChild_aggregateSinceLastMonth_NegativeScore() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])
        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 16, user: user),
                                       PointData(id: UUID(), month: Date(), points: 10, user: user)]
        user.dataPoints = dataPoints
        #expect(user.aggregateSinceLastMonth == -6)
    }

    @Test("POSITIVE - aggregate positive score") func testChild_aggregateSinceLastMonth_PositiveScore() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 14, user: user),
                                       PointData(id: UUID(), month: Date(), points: 24, user: user)]
        user.dataPoints = dataPoints
        #expect(user.aggregateSinceLastMonth == 10)
    }

    @Test("POSITIVE - aggregate no score") func testChild_aggregateSinceLastMonth_NoScore() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = []
        user.dataPoints = dataPoints
        #expect(user.aggregateSinceLastMonth == 0)
    }

    @Test("POSITIVE - aggregate single score") func testChild_aggregateSinceLastMonth_SingleScore() async throws {
        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: Date(), points: 99, user: childUser)]
        user.dataPoints = dataPoints
        #expect(user.aggregateSinceLastMonth == 99)
    }

    @Test("POSITIVE - orderdDataPoints") func testChild_orderedPoints() async throws {

        let date1 = Date(timeIntervalSince1970: 1000)
        let date2 = Date(timeIntervalSince1970: 1000000)
        let date3 = Date(timeIntervalSince1970: 10000000000)

        let user = User(id: UUID(),
                             dataPoints: [],
                             bounties: [],
                             name: "Test",
                             iceCreamPoints: 1000,
                             negativeIceCreamPoints: -100,
                             type: "child",
                             children: [])

        let dataPoints: [PointData] = [PointData(id: UUID(), month: date3, points: 3, user: user),
                                       PointData(id: UUID(), month: date1, points: 1, user: user),
                                       PointData(id: UUID(), month: date2, points: 2, user: user)]
        user.dataPoints = dataPoints
        #expect(user.orderedDataPoints[0].points == 1)
        #expect(user.orderedDataPoints[1].points == 2)
        #expect(user.orderedDataPoints[2].points == 3)
    }
}
