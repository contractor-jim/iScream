//
//  ChildDashboardPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing
import SwiftUI

struct ChildDashboardPresenterTests {

    var mockUserService: MockUserService
    let router: ChildDashboardRouterImp
    let interactor: ChildDashboardInteractorImp
    let presenter: ChildDashboardPresenterImp
    let entity: ChildDashboardEntityImp

    init() throws {
        mockUserService = MockUserService()
        router = ChildDashboardRouterImp()
        entity = ChildDashboardEntityImp()
        interactor = ChildDashboardInteractorImp(entity: entity, userService: mockUserService)
        presenter = ChildDashboardPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - ChildDashboardPresenterInit ") func testInit() throws {

        let presenter = ChildDashboardPresenterImp(interactor: interactor,
                                                   router: router)

        #expect(presenter.interactor != nil)
        #expect(presenter.router != nil)
    }

    @Test("POSITIVE - ChildDashboardPresenter - fetch user") func testFetch() async throws {
        let testUser = User.mockUser

        mockUserService.mockUser = testUser
        await presenter.fetch()

        #expect(presenter.user != nil)
        #expect(presenter.user == testUser)
        #expect(presenter.points.count == 2)
        #expect(presenter.points[0].points == 1000)
        #expect(presenter.points[1].points == 50)
    }

    @Test("POSITIVE - ChildDashboardPresenter - navPath return") func testNavPath() {
        // Set up expectation
        let router = ChildDashboardRouterImp()
        var nav = NavigationPath()
        nav.append("Test")
        // Append expectation
        router.nav = nav
        let presenter = ChildDashboardPresenterImp(interactor: interactor, router: router)

        #expect(presenter.navPath.wrappedValue.isEmpty == false)
        #expect(presenter.navPath.wrappedValue.count == 1)
        #expect(presenter.navPath.wrappedValue == nav)
    }
}
