//
//  ParentListChildrenInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing

struct ParentListChildrenInteractorTests {

    var mockUserService: MockUserService
    let router: ParentListChildrenRouter
    let interactor: ParentListChildrenInteractor
    let presenter: ParentListChildrenPresenterImp
    let entity: ParentListChildrenEntity

    init() throws {
        mockUserService = MockUserService()
        router = ParentListChildrenRouterImp()
        entity = ParentListChildrenEntityImp()
        interactor = ParentListChildrenInteractorImp(entity: entity, userService: mockUserService)
        presenter = ParentListChildrenPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - ParentListChildrenInteractorInit ") func testInit() throws {

        let interactor = ParentListChildrenInteractorImp(entity: entity,
                                                         userService: mockUserService)
        #expect(interactor.entity != nil)
        #expect(interactor.userService != nil)
    }

    @Test("POSITIVE - ParentListChildrenInteractor - fetch user") func testFetch() async throws {

        let mockedUser = User.mockUser
        mockUserService.mockUser = mockedUser

        let user = await interactor.fetchMyUser()
        try #require(user == mockedUser)
    }
}
