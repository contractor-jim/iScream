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
    let router: BountyRouter
    let interactor: BountyInteractor
    let presenter: BountyPresenter
    let entity: BountyEntity

    init() throws {
        mockUserService = MockUserService()
        router = BountyRouter()
        entity = BountyEntity()
        interactor = BountyInteractor(entity: entity, services: [mockUserService])!
        presenter = BountyPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - BountyPresenterInit ") func testInit() throws {

        let presenter = BountyPresenter(interactor: interactor,
                                        router: router)

        #expect(presenter?.interactor != nil)
        #expect(presenter?.router != nil)
    }

    @Test("POSITIVE - BountyPresenter - fetch user") func testFetch() async throws {
        let id = UUID()
        let authId = UUID()
        let profile = Profile(id: id,
                              userName: "McTest",
                              type: .parent,
                              points: 1000,
                              negativePoints: -100,
                              parentId: nil,
                              authId: authId,
                              children: [],
                              managedBounties: [],
                              bounties: [])

        mockUserService.mockProfile = profile

        try await presenter.fetch()

        #expect(presenter.profile != nil)
        #expect(presenter.profile == profile)
    }

    @Test("POSITIVE - BountyPresenter - navPath return") func testNavPath() {
        // Set up expectation
        let router = BountyRouter()
        var nav = NavigationPath()
        nav.append("Test")
        // Append expectation
        router.nav = nav
        let presenter = BountyPresenter(interactor: interactor, router: router)

        #expect(presenter?.navPath.wrappedValue.isEmpty == false)
        #expect(presenter?.navPath.wrappedValue.count == 1)
        #expect(presenter?.navPath.wrappedValue == nav)
    }
}
