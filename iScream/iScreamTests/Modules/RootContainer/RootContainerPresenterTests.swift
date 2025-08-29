//
//  RootContainerPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import Testing
@testable import iScream

struct RootContainerPresenterTests {

    var mockService: MockUserService
    let router: MockRootContainerRouter
    let interactor: MockRootContainerInteractor
    let presenter: RootContainerPresenterImp

    init() throws {
        mockService = MockUserService()
        router = MockRootContainerRouter()
        interactor = MockRootContainerInteractor(entity: MockRootContainerEntity(), userService: mockService)
        presenter = RootContainerPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - RootContainerPresenter - fetch user") func testFetch() async throws {

        mockService.mockUser = User(dataPoints: [],
                                    openBounties: Bounty.threeCorrectIncompleteBounties,
                                    completedBounties: Bounty.threeCorrectCompletedBounties,
                                    name: "McTest",
                                    iceCreamPoints: 1000)
        await presenter.fetch()
    }

    @Test("POSITIVE - RootContainerPresenter - nil user") func testGetBountyBadgeCountNilUser_ReturnsNil() {
        #expect(presenter.user == nil)
        #expect(presenter.getBountyBadgeCount() == 0)
    }

    @Test("POSITIVE - RootContainerPresenter - getBountyBadgeCount",
          arguments:[
            (openBounties: Bounty.threeCorrectIncompleteBounties,
             closedBounties: Bounty.threeCorrectCompletedBounties,
             userType: UserType.child,
             expectedCount: 3),

            (openBounties: Bounty.threeCorrectIncompleteBounties,
             closedBounties: Bounty.threeCorrectCompletedBounties,
             userType: UserType.parent,
             expectedCount: 0),

            (openBounties: Bounty.threeCorrectIncompleteBounties,
             closedBounties: Bounty.threeCorrectCompletedBounties,
             userType: UserType.unknown,
             expectedCount: -1)

    ])
    func testGetChildBountyBadgeCount_ReturnsCountOf3(
        openBounties: [Bounty],
        closedBounties: [Bounty],
        userType: UserType,
        expectedCount: Int
        ) async throws {
        mockService.mockUser = User(dataPoints: [],
                                    openBounties: openBounties,
                                    completedBounties: closedBounties,
                                    name: "McTest",
                                    iceCreamPoints: 1000,
                                    type: userType)
        await presenter.fetch()
        try #require(presenter.user != nil)
        #expect(presenter.getBountyBadgeCount() == expectedCount)
    }
}
