//
//  BountyInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing

struct BountyInteractorTests {

    var mockUserService: MockUserService
    let router: BountyRouter
    let interactor: BountyInteractor
    let presenter: BountyPresenterImp
    let entity: BountyEntity

    init() throws {
        mockUserService = MockUserService()
        router = BountyRouterImp()
        entity = BountyEntityImp()
        interactor = BountyInteractorImp(entity: entity, userService: mockUserService)
        presenter = BountyPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - BountyInteractorInit ") func testInit() throws {

        let interactor = BountyInteractorImp(entity: entity,
                                             userService: mockUserService)
        #expect(interactor.entity != nil)
        #expect(interactor.userService != nil)
    }

    @Test("POSITIVE - BountyInteractor - fetch user") func testFetch() async throws {

        let mockedUser = User.mockUser
        mockUserService.mockUser = mockedUser

        let user = await interactor.fetchMyUser()
        try #require(user == mockedUser)
    }
}
