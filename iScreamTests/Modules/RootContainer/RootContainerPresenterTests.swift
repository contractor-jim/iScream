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
    let router: RootContainerRouter
    let interactor: RootContainerInteractor
    let presenter: RootContainerPresenter

    init() throws {
        mockUserService = MockUserService()
        router = RootContainerRouter()
        interactor = RootContainerInteractor(entity: RootContainerEntity(), services: [mockUserService])!
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
                              bounties: [],
                              dataPoints: [],
                              achievements: [])

        mockUserService.mockProfile = profile
        try await presenter.fetch()

        #expect(presenter.userProfile != nil)
        #expect(presenter.userProfile == profile)
    }

    @Test("POSITIVE - RootContainerPresenter - nil user") func testGetBountyBadgeCountNilUser_ReturnsNil() {
        #expect(presenter.userProfile == nil)
        #expect(presenter.getBountyBadgeCount() == 0)
    }

    @Test("POSITIVE - RootContainerPresenter - getBountyBadgeCount", arguments: [
            (userType: "child",
             expectedCount: 3),

            (userType: "parent",
             expectedCount: 1),

            (userType: "unknown",
             expectedCount: 0)
    ])
    func testGetChildBountyBadgeCount_ReturnsCountOf3(
        userType: String,
        expectedCount: Int
        ) async throws {
            let parentId = UUID()

            let childProfile = Profile(id: parentId,
                                       userName: "McTest",
                                       type: .child,
                                       points: 1000,
                                       negativePoints: -100,
                                       parentId: nil,
                                       authId: UUID(),
                                       children: [],
                                       managedBounties: [],
                                       bounties:
                                         [Bounty(id: UUID(),
                                                 parentId: UUID(),
                                                 title: "Test1",
                                                 points: 1,
                                                 completed: true,
                                                 pendingComplete: true,
                                                 rarity: .bronze),
                                          Bounty(id: UUID(),
                                                 parentId: UUID(),
                                                 title: "Test2",
                                                 points: 2,
                                                 completed: false,
                                                 pendingComplete: true,
                                                 rarity: .bronze),
                                          Bounty(id: UUID(),
                                                 parentId: UUID(),
                                                 title: "Test3",
                                                 points: 3,
                                                 completed: false,
                                                 pendingComplete: false,
                                                 rarity: .bronze)],
                                       dataPoints: [],
                                       achievements: [])

            var profileType: UserType {
                if userType == "child" {
                    return .child
                }

                if userType == "parent" {
                    return .parent
                }

                return .unknown
            }
            let profile = Profile(id: parentId,
                                  userName: "McTest",
                                  type: profileType,
                                  points: 1000,
                                  negativePoints: -100,
                                  parentId: nil,
                                  authId: UUID(),
                                  children: [childProfile],
                                  managedBounties: [],
                                  bounties:
                                    [Bounty(id: UUID(),
                                            parentId: UUID(),
                                            title: "Test1",
                                            points: 1,
                                            completed: true,
                                            pendingComplete: true,
                                            rarity: .bronze),
                                     Bounty(id: UUID(),
                                            parentId: UUID(),
                                            title: "Test2",
                                            points: 2,
                                            completed: false,
                                            pendingComplete: true,
                                            rarity: .bronze),
                                     Bounty(id: UUID(),
                                            parentId: UUID(),
                                            title: "Test3",
                                            points: 3,
                                            completed: false,
                                            pendingComplete: true,
                                            rarity: .bronze),
                                     Bounty(id: UUID(),
                                            parentId: UUID(),
                                            title: "Test1",
                                            points: 1,
                                            completed: true,
                                            pendingComplete: true,
                                            rarity: .bronze),
                                     Bounty(id: UUID(),
                                            parentId: UUID(),
                                            title: "Test3",
                                            points: 3,
                                            completed: false,
                                            pendingComplete: true,
                                            rarity: .bronze),
                                     Bounty(id: UUID(),
                                            parentId: UUID(),
                                            title: "Test3",
                                            points: 3,
                                            completed: true,
                                            pendingComplete: true,
                                            rarity: .bronze)],
                                  dataPoints: [],
                                  achievements: [])

            mockUserService.mockProfile = profile
            try await presenter.fetch()
            try #require(presenter.userProfile != nil)
            #expect(presenter.getBountyBadgeCount() == expectedCount)
    }

    @Test("NEGATIVE - RootContainerPresenter - fetch user profile fails and sets error") func testFetchError() async throws {
        mockUserService.shouldThrowError = TestError.loginError("Test")
        _ = try await presenter.fetch()

        #expect(presenter.errorShown == true)
        #expect(presenter.requiringLogIn == true)
        guard let error = presenter.loginError as? LoginError else {
            #expect(Bool(false), "Incorrect error type.")
            return
        }

        #expect(error == LoginError.failedToLoadProfile)
    }
}
