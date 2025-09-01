//
//  ChildDashboardInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

import Testing
@testable import iScream

struct ChildDashboardInteractorTests {

    var mockUserService: MockUserService
    let router: ChildDashboardRouter
    let interactor: ChildDashboardInteractor
    let presenter: ChildDashboardPresenterImp
    let entity: ChildDashboardEntity

    init() throws {
        mockUserService = MockUserService()
        router = ChildDashboardRouterImp()
        entity = ChildDashboardEntityImp()
        interactor = ChildDashboardInteractorImp(entity: entity, userService: mockUserService)
        presenter = ChildDashboardPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - ChildDashboardInteractorInit ") func testInit() throws {

        let interactor = ChildDashboardInteractorImp(entity: entity,
                                                     userService: mockUserService)
        #expect(interactor.entity != nil)
        #expect(interactor.userService != nil)
    }

    @Test("POSITIVE - ChildDashboardInteractor - fetch user") func testFetch() async throws {

        let mockedUser = User.mockUser
        mockUserService.mockUser = mockedUser

        let user = await interactor.fetchMyUser()
        try #require(user == mockedUser)
    }

}
