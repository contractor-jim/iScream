//
//  BountyPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing
import SwiftUI

struct BountyPresenterTests {

    var mockUserService: MockUserService
    let router: BountyRouterImp
    let interactor: BountyInteractorImp
    let presenter: BountyPresenterImp
    let entity: BountyEntityImp

    init() throws {
        mockUserService = MockUserService()
        router = BountyRouterImp()
        entity = BountyEntityImp()
        interactor = BountyInteractorImp(entity: entity, userService: mockUserService)
        presenter = BountyPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - BountyPresenterInit ") func testInit() throws {

        let presenter = BountyPresenterImp(interactor: interactor,
                                                   router: router)

        #expect(presenter.interactor != nil)
        #expect(presenter.router != nil)
    }

    @Test("POSITIVE - BountyPresenter - fetch user") func testFetch() async throws {
        let testUser = User.mockUser

        mockUserService.mockUser = testUser
        await presenter.fetch()

        #expect(presenter.user != nil)
        #expect(presenter.user == testUser)
    }

    @Test("POSITIVE - BountyPresenter - navPath return") func testNavPath() {
        // Set up expectation
        let router = BountyRouterImp()
        var nav = NavigationPath()
        nav.append("Test")
        // Append expectation
        router.nav = nav
        let presenter = BountyPresenterImp(interactor: interactor, router: router)

        #expect(presenter.navPath.wrappedValue.isEmpty == false)
        #expect(presenter.navPath.wrappedValue.count == 1)
        #expect(presenter.navPath.wrappedValue == nav)
    }
}
