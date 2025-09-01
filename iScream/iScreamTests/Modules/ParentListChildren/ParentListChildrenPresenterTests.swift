//
//  ParentListChildrenPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing
import SwiftUI

struct ParentListChildrenPresenterTests {

    var mockUserService: MockUserService
    let router: ParentListChildrenRouterImp
    let interactor: ParentListChildrenInteractorImp
    let presenter: ParentListChildrenPresenterImp
    let entity: ParentListChildrenEntityImp

    init() throws {
        mockUserService = MockUserService()
        router = ParentListChildrenRouterImp()
        entity = ParentListChildrenEntityImp()
        interactor = ParentListChildrenInteractorImp(entity: entity, userService: mockUserService)
        presenter = ParentListChildrenPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - ParentListChildrenPresenterInit ") func testInit() throws {

        let presenter = ParentListChildrenPresenterImp(interactor: interactor,
                                                        router: router)

        #expect(presenter.interactor != nil)
        #expect(presenter.router != nil)
    }

    @Test("POSITIVE - ParentListChildrenPresenter - fetch user") func testFetch() async throws {
        let testUser = User(dataPoints: [],
                            openBounties: Bounty.threeCorrectIncompleteBounties,
                            completedBounties: Bounty.threeCorrectCompletedBounties,
                            name: "McTest",
                            iceCreamPoints: 1000)

        mockUserService.mockUser = testUser
        await presenter.fetch()

        #expect(presenter.user != nil)
        #expect(presenter.user == testUser)
    }

    @Test("POSITIVE - ParentListChildrenPresenter - navPath return") func testNavPath() {
        // Set up expectation
        let router = ParentListChildrenRouterImp()
        var nav = NavigationPath()
        nav.append("Test")
        // Append expectation
        router.nav = nav
        let presenter = ParentListChildrenPresenterImp(interactor: interactor, router: router)

        #expect(presenter.navPath.wrappedValue.isEmpty == false)
        #expect(presenter.navPath.wrappedValue.count == 1)
        #expect(presenter.navPath.wrappedValue == nav)
    }

    @Test("POSITIVE - ParentListChildrenPresenter - navPath return") func testNavigateChildDetail() {
        // Set up expectation
        let router = ParentListChildrenRouterImp()
        var nav = NavigationPath()

        // Append expectation
        router.nav = nav
        let presenter = ParentListChildrenPresenterImp(interactor: interactor, router: router)

        // Navigate to user
        // TODO: Need to make this user as part of the mocked model to refactor out duplicate generation
        let mockedUser = User(dataPoints: [],
                              openBounties: Bounty.threeCorrectIncompleteBounties,
                              completedBounties: Bounty.threeCorrectCompletedBounties,
                              name: "McTest",
                              iceCreamPoints: 1000)
        presenter.navigateChildDetailView(user: mockedUser)

        #expect(presenter.navPath.wrappedValue.isEmpty == false)
        #expect(presenter.navPath.wrappedValue.count == 1)
    }
}
