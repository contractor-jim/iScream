//
//  RootContainerPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Testing

struct RootContainerPresenterTests {

    var mockUserService: MockUserService
    let router: MockRootContainerRouter
    let interactor: MockRootContainerInteractor
    let presenter: RootContainerPresenterImp

    init() throws {
        mockUserService = MockUserService()
        router = MockRootContainerRouter()
        interactor = MockRootContainerInteractor(entity: MockRootContainerEntity(), userService: mockUserService)
        presenter = RootContainerPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - RootContainerPresenter - fetch user") func testFetch() async throws {
        let testUser = User.mockUser

        mockUserService.mockUser = testUser
        await presenter.fetch()

        #expect(presenter.user != nil)
        #expect(presenter.user == testUser)
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
             expectedCount: 0)

    ])
    func testGetChildBountyBadgeCount_ReturnsCountOf3(
        openBounties: [Bounty],
        closedBounties: [Bounty],
        userType: UserType,
        expectedCount: Int
        ) async throws {
            mockUserService.mockUser = User(dataPoints: [],
                                            openBounties: openBounties,
                                            completedBounties: closedBounties,
                                            name: "McTest",
                                            iceCreamPoints: 1,
                                            negativeIceCreamPoints: 1,
                                            type: userType,
                                            children: [])
        await presenter.fetch()
        try #require(presenter.user != nil)
        #expect(presenter.getBountyBadgeCount() == expectedCount)
    }
}
