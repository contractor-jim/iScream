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

    @Test("POSITIVE - RootContainerPresenter - child user") func testGetChildBountyBadgeCount_ReturnsCountOf3() async throws {
        mockService.mockUser = User(dataPoints: [],
                                    openBounties: Bounty.threeCorrectIncompleteBounties,
                                    completedBounties: Bounty.threeCorrectCompletedBounties,
                                    name: "McTest",
                                    iceCreamPoints: 1000,
                                    type: .child)
        await presenter.fetch()
        try #require(presenter.user != nil)
        #expect(presenter.getBountyBadgeCount() == 3)
    }

    @Test("POSITIVE - RootContainerPresenter - parent user INCOMPLETE") func testGetParentBountyBadgeCount_INCOMPLETE() async throws {
        mockService.mockUser = User(dataPoints: [],
                                    openBounties: Bounty.threeCorrectIncompleteBounties,
                                    completedBounties: Bounty.threeCorrectCompletedBounties,
                                    name: "McTest",
                                    iceCreamPoints: 1000,
                                    type: .parent)

        await presenter.fetch()
        try #require(presenter.user != nil)
        #expect(presenter.getBountyBadgeCount() == 0)
    }

    @Test("POSITIVE - RootContainerPresenter - unknown user", .disabled("INCOMPLETE"))
    func testGetUnknownUserBountyBadgeCount_ReturnsMinusOne() async throws {
        mockService.mockUser = User(dataPoints: [],
                                    openBounties: Bounty.threeCorrectIncompleteBounties,
                                    completedBounties: Bounty.threeCorrectCompletedBounties,
                                    name: "McTest",
                                    iceCreamPoints: 1000,
                                    type: .unknown)
        await presenter.fetch()
        try #require(presenter.user != nil)
        #expect(presenter.getBountyBadgeCount() == -1)
    }
}
