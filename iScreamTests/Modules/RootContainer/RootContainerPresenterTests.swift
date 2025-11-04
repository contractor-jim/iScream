//
//  RootContainerPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Testing
import Foundation

struct RootContainerPresenterTests {

    var mockUserService: MockUserService
    let router: MockRootContainerRouter
    let interactor: MockRootContainerInteractor
    let presenter: RootContainerPresenter

    init() throws {
        mockUserService = MockUserService()
        router = MockRootContainerRouter()
        interactor = MockRootContainerInteractor(entity: MockRootContainerEntity(), services: [mockUserService])!
        presenter = RootContainerPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - RootContainerPresenter - fetch user profile") func testFetch() async throws {
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
        await presenter.fetch()

        #expect(presenter.userProfile != nil)
        #expect(presenter.userProfile == profile)
    }

    @Test("POSITIVE - RootContainerPresenter - nil user") func testGetBountyBadgeCountNilUser_ReturnsNil() {
        #expect(presenter.userProfile == nil)
        #expect(presenter.getBountyBadgeCount() == 0)
    }

    @Test("POSITIVE - RootContainerPresenter - getBountyBadgeCount",
          arguments: [
            // TODO: Need to fix this
            /*
            (userType: "child",
             expectedCount: 3)
             */
            (userType: "parent",
             expectedCount: 0),

            (userType: "unknown",
             expectedCount: 0)
    ])
    func testGetChildBountyBadgeCount_ReturnsCountOf3(
        userType: String,
        expectedCount: Int
        ) async throws {
            let parentId = UUID()
            let profile = Profile(id: parentId,
                                  userName: "McTest",
                                  type: .parent,
                                  points: 1000,
                                  negativePoints: -100,
                                  parentId: nil,
                                  authId: UUID(),
                                  children: [],
                                  managedBounties: [],
                                  bounties:
                                    [Bounty(id: UUID(),
                                            parentId: parentId,
                                            title: "Test1",
                                            points: 1,
                                            completed: true,
                                            profile: [Profile.mockProfile]),
                                     Bounty(id: UUID(),
                                            parentId: parentId,
                                            title: "Test2",
                                            points: 2,
                                            completed: true,
                                            profile:
                                                [Profile.mockProfile]),
                                     Bounty(id: UUID(),
                                            parentId: parentId,
                                            title: "Test3",
                                            points: 3,
                                            completed: true,
                                            profile: [Profile.mockProfile]),
                                     Bounty(id: UUID(),
                                            parentId: parentId,
                                            title: "Test1",
                                            points: 1,
                                            completed: false,
                                            profile: [Profile.mockProfile]),
                                     Bounty(id: UUID(),
                                            parentId: parentId,
                                            title: "Test2",
                                            points: 2,
                                            completed: false,
                                            profile: [Profile.mockProfile]),
                                     Bounty(id: UUID(),
                                            parentId: parentId,
                                            title: "Test3",
                                            points: 3,
                                            completed: false,
                                            profile: [Profile.mockProfile])])

            mockUserService.mockProfile = profile
            await presenter.fetch()
            try #require(presenter.userProfile != nil)
            #expect(presenter.getBountyBadgeCount() == expectedCount)
    }
}
