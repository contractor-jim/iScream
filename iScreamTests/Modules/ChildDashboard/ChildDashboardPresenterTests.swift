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
    let router: ChildDashboardRouter
    let interactor: ChildDashboardInteractor
    let presenter: ChildDashboardPresenter
    let entity: ChildDashboardEntity

    init() throws {
        mockUserService = MockUserService()
        router = ChildDashboardRouter()
        entity = ChildDashboardEntity()
        interactor = ChildDashboardInteractor(entity: entity, services: [mockUserService])!
        presenter = ChildDashboardPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - ChildDashboardPresenterInit ") func testInit() throws {

        let presenter = ChildDashboardPresenter(interactor: interactor,
                                                   router: router)

        #expect(presenter?.interactor != nil)
        #expect(presenter?.router != nil)
    }

    @Test("POSITIVE - ChildDashboardPresenter - fetch user") func testFetch() async throws {
        let testProfile = Profile.mockProfile

        mockUserService.mockProfile = testProfile
        try await presenter.fetch()
        #expect(presenter.profile == testProfile)
    }

    @Test("POSITIVE - ChildDashboardPresenter - navPath return") func testNavPath() {
        // Set up expectation
        let router = ChildDashboardRouter()
        var nav = NavigationPath()
        nav.append("Test")
        // Append expectation
        router.nav = nav
        let presenter = ChildDashboardPresenter(interactor: interactor, router: router)

        #expect(presenter?.navPath.wrappedValue.isEmpty == false)
        #expect(presenter?.navPath.wrappedValue.count == 1)
        #expect(presenter?.navPath.wrappedValue == nav)
    }

    @Test("POSITIVE - ChildDashboardPresenter - user bounty scores add up", .disabled()) func testUserBountyCounts() async throws {
        let testProfile = Profile.mockProfile
        mockUserService.mockProfile = testProfile
        try await presenter.fetch()
        #expect(presenter.profile == testProfile)
        #expect(presenter.openBountyCount == 1 )
        #expect(presenter.totalBountyCount == 2 )
    }

    @Test("POSITIVE - ChildDashboardPresenter - this year is returned") func testCurrentYear() async {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        #expect(presenter.getThisYear() == year)
    }
}
