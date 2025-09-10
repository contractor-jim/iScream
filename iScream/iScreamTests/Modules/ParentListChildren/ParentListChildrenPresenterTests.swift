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
    let router: ParentListChildrenRouter
    let interactor: ParentListChildrenInteractor
    let presenter: ParentListChildrenPresenter
    let entity: ParentListChildrenEntity

    init() throws {
        mockUserService = MockUserService()
        router = ParentListChildrenRouter()
        entity = ParentListChildrenEntity()
        interactor = ParentListChildrenInteractor(entity: entity, services: [mockUserService])!
        presenter = ParentListChildrenPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - ParentListChildrenPresenterInit ") func testInit() throws {

        let presenter = ParentListChildrenPresenter(interactor: interactor,
                                                        router: router)

        #expect(presenter?.interactor != nil)
        #expect(presenter?.router != nil)
    }

    @Test("POSITIVE - ParentListChildrenPresenter - fetch user") func testFetch() async throws {
        let testUser = User.mockUser

        mockUserService.mockUser = testUser
        await presenter.fetch()

        #expect(presenter.user != nil)
        #expect(presenter.user == testUser)
    }

    @Test("POSITIVE - ParentListChildrenPresenter - navPath return") func testNavPath() {
        // Set up expectation
        let router = ParentListChildrenRouter()
        var nav = NavigationPath()
        nav.append("Test")
        // Append expectation
        router.nav = nav
        let presenter = ParentListChildrenPresenter(interactor: interactor, router: router)

        #expect(presenter?.navPath.wrappedValue.isEmpty == false)
        #expect(presenter?.navPath.wrappedValue.count == 1)
        #expect(presenter?.navPath.wrappedValue == nav)
    }

    @Test("POSITIVE - ParentListChildrenPresenter - navPath return") func testNavigateChildDetail() {
        // Set up expectation
        let router = ParentListChildrenRouter()
        let nav = NavigationPath()

        // Append expectation
        router.nav = nav
        let presenter = ParentListChildrenPresenter(interactor: interactor, router: router)

        // Navigate to user
        // TODO: Need to make this user as part of the mocked model to refactor out duplicate generation
        let mockedUser = User.mockUser
        presenter?.navigateChildDetailView(user: mockedUser)

        #expect(presenter?.navPath.wrappedValue.isEmpty == false)
        #expect(presenter?.navPath.wrappedValue.count == 1)
    }
}
