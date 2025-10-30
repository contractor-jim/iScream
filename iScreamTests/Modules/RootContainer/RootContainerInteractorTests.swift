//
//  RootContainerInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing
import Foundation

struct RootContainerInteractorTests {

    var mockUserService: MockUserService
    let router: MockRootContainerRouter
    let interactor: RootContainerInteractor
    let presenter: RootContainerPresenter
    let entity: MockRootContainerEntity

    init() throws {
        mockUserService = MockUserService()
        router = MockRootContainerRouter()
        interactor = RootContainerInteractor(entity: MockRootContainerEntity(), services: [mockUserService])!
        presenter = RootContainerPresenter(interactor: interactor, router: router)!
        entity = MockRootContainerEntity()
    }

    @Test("POSITIVE - RootContainerInteractorInit ") func testInit() throws {

        let interactor = RootContainerInteractor(entity: entity,
                                                 services: [mockUserService])

        #expect(interactor?.entity != nil)
        let mockEntity = try #require(interactor?.entity as? MockRootContainerEntity)
        #expect(mockEntity == self.entity)

        #expect(interactor?.userService != nil)
        let mockUserService = try #require(interactor?.userService as? MockUserService)
        #expect(mockUserService == self.mockUserService)
    }

    @Test("POSITIVE - RootContainerInteractor - fetch user") func testFetch() async throws {

        let id = UUID()
        let authId = UUID()
        let profile = Profile(id: id,
                              userName: "McTest",
                              type: "parent",
                              points: 1000,
                              negativePoints: -100,
                              parentId: nil,
                              authId: authId,
                              children: [])

        mockUserService.mockProfile = profile

        let userProfile = try await interactor.fetchMyUserProfile()
        try #require(profile == userProfile)
    }
}
