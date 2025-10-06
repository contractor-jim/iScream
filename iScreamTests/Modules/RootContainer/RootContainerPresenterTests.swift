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

    @Test("POSITIVE - RootContainerPresenter - fetch user") func testFetch() async throws {
        let testUser = User.mockUser

        mockUserService.mockUser = testUser
        await presenter.fetch()

        #expect(presenter.user != nil)
        #expect(presenter.user == testUser)
    }

    @Test("POSITIVE - RootContainerPresenter - nil user") func testGetBountyBadgeCountNilUser_ReturnsNil() {
        #expect(presenter.user == nil)
        #expect(presenter.getBountyBadgeCount() == 0)
    }

    /*
    @Test("POSITIVE - RootContainerPresenter - getBountyBadgeCount",
          arguments: [
            (userType: "child",
             expectedCount: 3),

            (userType: "parent",
             expectedCount: 0),

            (userType: "unknown",
             expectedCount: 0)

    ])
    func testGetChildBountyBadgeCount_ReturnsCountOf3(
        userType: String,
        expectedCount: Int
        ) async throws {
            let formatter = ISO8601DateFormatter()

            let user = User(id: UUID(),
                            dataPoints: [],
                            bounties: [],
                            name: "McTest",
                            iceCreamPoints: 1,
                            negativeIceCreamPoints: 1,
                            type: userType,
                            children: [])

            user.dataPoints = [PointData(id: UUID(),
                                         month: formatter.date(from: "2025-01-01T00:00:00Z")!,
                                         points: 5, user:
                                            user),
                               PointData(id: UUID(),
                                         month: formatter.date(from: "2025-01-01T00:00:00Z")!,
                                         points: 11,
                                         user: user)]

            user.bounties = [Bounty(id: UUID(), title: "Test1", points: 1, completed: true, user: user),
                             Bounty(id: UUID(), title: "Test2", points: 2, completed: true, user: user),
                             Bounty(id: UUID(), title: "Test3", points: 3, completed: true, user: user),
                             Bounty(id: UUID(), title: "Test1", points: 1, completed: false, user: user),
                             Bounty(id: UUID(), title: "Test2", points: 2, completed: false, user: user),
                             Bounty(id: UUID(), title: "Test3", points: 3, completed: false, user: user)]

        mockUserService.mockUser = user
        await presenter.fetch()
        try #require(presenter.user != nil)
        #expect(presenter.getBountyBadgeCount() == expectedCount)
    }
    */

    @Test("POSITIVE - RootContainerPresenter - testEmailValidation",
          arguments: [
            (email: "",
             result: "Missing Email"),

            (email: "flobbyDobby",
             result: "Invalid Email"),

            (email: "test@test.com",
             result: "")
    ])
    func testEmailValidation_ReturnsCountOf3(
        email: String,
        result: String
    ) async throws {
        presenter.email = email
        #expect(presenter.isValidEmail() == result)
    }

    @Test("POSITIVE - RootContainerPresenter - testPasswordValidation",
          arguments: [
            (password: "",
             result: "Missing Password"),

            (password: "flobbyDobby",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"),

            (password: "12343",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"),

            (password: "*£$£@$£$@£",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"),

            (password: "*ValidPassword1_",
             result: "")
    ])
    func testEmailValidation_ReturnsCountOf3(
        password: String,
        result: String
    ) async throws {
        presenter.password = password
        #expect(presenter.isValidPassword() == result)
    }

    @Test("POSITIVE - RootContainerPresenter - testSignUpNicknameValidation",
          arguments: [
            (nickname: "",
             result: "Missing Nickname"),

            (nickname: "a",
             result: "Invalid Nickname: A-Z, 2 to 15 charachters long"),

            (nickname: "12343",
             result: "Invalid Nickname: A-Z, 2 to 15 charachters long"),

            (nickname: "*£$£VBD$£$@£",
             result: "Invalid Nickname: A-Z, 2 to 15 charachters long"),

            (nickname: "Alan",
             result: ""),

            (nickname: "alan",
             result: "")
    ])
    func testEmailValidation_ReturnsCountOf3(
        nickname: String,
        result: String
    ) async throws {
        presenter.signupUserName = nickname
        #expect(presenter.isValidNickName() == result)
    }

}
