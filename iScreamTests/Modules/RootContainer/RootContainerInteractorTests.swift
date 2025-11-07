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
    let router: RootContainerRouter
    let interactor: RootContainerInteractor
    let presenter: RootContainerPresenter
    let entity: MockRootContainerEntity

    init() throws {
        mockUserService = MockUserService()
        router = RootContainerRouter()
        entity = MockRootContainerEntity()
        interactor = RootContainerInteractor(entity: entity, services: [mockUserService])!
        presenter = RootContainerPresenter(interactor: interactor, router: router)!

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

    @Test("NEGATIVE - RootContainerInteractor - missing user service") func testFetch_missingUserService_throws() async throws {
//        let mockUserService = MockUserService()
        let entity = MockRootContainerEntity()
        let interactor = RootContainerInteractor(entity: entity, services: [mockUserService])!
        interactor.userService = nil
        await #expect(throws: (UserError.userServiceNotFound).self) {
            _ = try await interactor.fetchMyUserProfile()
        }
    }

    @Test("POSITIVE - RootContainerInteractor - fetch user") func testFetch() async throws {

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
                              bounties: [],
                              dataPoints: [],
                              achievements: [])

        mockUserService.mockProfile = profile

        let userProfile = try await interactor.fetchMyUserProfile()
        try #require(profile == userProfile)
    }

    @Test("NEGATIVE - RootContainerInteractor - fetch user throws") func testFetch_throws() async throws {
        let mockUserService = MockUserService()
        let entity = MockRootContainerEntity()
        mockUserService.shouldThrowError = TestError.loginError("Test")
        let interactor = RootContainerInteractor(entity: entity, services: [mockUserService])!
        await #expect(throws: (UserError.fetchUserProfileFailed).self) {
            _ = try await interactor.fetchMyUserProfile()
        }
    }
}
