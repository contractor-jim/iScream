//
//  ParentListChildrenInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing
import Foundation

struct ParentListChildrenInteractorTests {

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

    @Test("POSITIVE - ParentListChildrenInteractorInit ") func testInit() throws {

        let interactor = ParentListChildrenInteractor(entity: entity,
                                                      services: [mockUserService])
        #expect(interactor?.entity != nil)
        #expect(interactor?.userService != nil)
    }

    @Test("POSITIVE - ParentListChildrenInteractor - fetch user profile") func testFetch() async throws {
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

        let userProfile = try await interactor.fetchMyUserProfile()
        try #require(userProfile == profile)
    }
}
