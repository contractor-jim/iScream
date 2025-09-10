//
//  ChildDashboardInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing

struct ChildDashboardInteractorTests {

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

    @Test("POSITIVE - ChildDashboardInteractorInit ") func testInit() throws {

        let interactor = ChildDashboardInteractor(entity: entity,
                                                  services: [mockUserService])
        #expect(interactor?.entity != nil)
        #expect(interactor?.userService != nil)
    }

    @Test("POSITIVE - ChildDashboardInteractor - fetch user") func testFetch() async throws {

        let mockedUser = User.mockUser
        mockUserService.mockUser = mockedUser

        let user = await interactor.fetchMyUser()
        try #require(user == mockedUser)
    }
}
