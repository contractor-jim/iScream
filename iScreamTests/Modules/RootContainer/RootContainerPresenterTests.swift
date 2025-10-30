//
//  RootContainerPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Testing
import Foundation

struct RootContainerPresenterTests {

    var mockUserService: MockUserService
    let router: MockRootContainerRouter
    let interactor: MockRootContainerInteractor
    let presenter: RootContainerPresenter

    init() throws {
        mockUserService = MockUserService()
        router = MockRootContainerRouter()
        interactor = MockRootContainerInteractor(entity: MockRootContainerEntity(), services: [mockUserService])!
        presenter = RootContainerPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - RootContainerPresenter - fetch user profile") func testFetch() async throws {
        let id = UUID()
        let authId = UUID()
        let profile = Profile(id: id,
                              userName: "McTest",
                              type: "parent",
                              points: 1000,
                              negativePoints: -100,
                              parentId: nil,
                              authId: authId,
                              children: [])

        mockUserService.mockProfile = profile
        await presenter.fetch()

        #expect(presenter.userProfile != nil)
        #expect(presenter.userProfile == profile)
    }

    @Test("POSITIVE - RootContainerPresenter - nil user") func testGetBountyBadgeCountNilUser_ReturnsNil() {
        #expect(presenter.userProfile == nil)
        #expect(presenter.getBountyBadgeCount() == 0)
    }

    /*
    @Test("POSITIVE - RootContainerPresenter - getBountyBadgeCount",
          arguments: [
            (userType: "child",
             expectedCount: 3),

            (userType: "parent",
             expectedCount: 0),

            (userType: "unknown",
             expectedCount: 0)

    ])
    func testGetChildBountyBadgeCount_ReturnsCountOf3(
        userType: String,
        expectedCount: Int
        ) async throws {
            let formatter = ISO8601DateFormatter()

            let user = User(id: UUID(),
                            dataPoints: [],
                            bounties: [],
                            name: "McTest",
                            iceCreamPoints: 1,
                            negativeIceCreamPoints: 1,
                            type: userType,
                            children: [])

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

        mockUserService.mockUser = user
        await presenter.fetch()
        try #require(presenter.user != nil)
        #expect(presenter.getBountyBadgeCount() == expectedCount)
    }
    */
}
