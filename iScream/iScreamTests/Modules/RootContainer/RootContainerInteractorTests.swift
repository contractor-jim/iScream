//
//  RootContainerInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

import Testing
@testable import iScream

struct RootContainerInteractorTests {

    var mockUserService: MockUserService
    let router: MockRootContainerRouter
    let interactor: RootContainerInteractor
    let presenter: RootContainerPresenterImp
    let entity: MockRootContainerEntity

    init() throws {
        mockUserService = MockUserService()
        router = MockRootContainerRouter()
        interactor = RootContainerInteractorImp(entity: MockRootContainerEntity(), userService: mockUserService)
        presenter = RootContainerPresenterImp(interactor: interactor, router: router)
        entity = MockRootContainerEntity()
    }

    @Test("POSITIVE - RootContainerInteractorInit ") func testInit() throws {

        let interactor = RootContainerInteractorImp(entity: entity,
                                       userService: mockUserService)

        #expect(interactor.entity != nil)
        let mockEntity = try #require(interactor.entity as? MockRootContainerEntity)
        #expect(mockEntity == self.entity)

        #expect(interactor.userService != nil)
        let mockUserService = try #require(interactor.userService as? MockUserService)
        #expect(mockUserService == self.mockUserService)
    }

    @Test("POSITIVE - RootContainerInteractor - fetch user") func testFetch() async throws {

        let mockedUser = User.mockUser
        mockUserService.mockUser = mockedUser

        let user = await interactor.fetchMyUser()
        try #require(user == mockedUser)
    }
}
