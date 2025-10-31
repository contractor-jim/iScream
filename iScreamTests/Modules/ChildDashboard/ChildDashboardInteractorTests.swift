//
//  ChildDashboardInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing
import Foundation

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
        let id = UUID()
        let authId = UUID()
        let mockProfile = Profile(id: id,
                              userName: "McTest",
                              type: .parent,
                              points: 1000,
                              negativePoints: -100,
                              parentId: nil,
                              authId: authId,
                              children: [],
                              managedBounties: [],
                              bounties: [])

        mockUserService.mockProfile = mockProfile

        let profile = try await interactor.fetchMyUserProfile()
        try #require(mockProfile == profile)
    }
}
