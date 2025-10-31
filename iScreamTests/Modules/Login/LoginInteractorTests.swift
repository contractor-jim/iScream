//
//  LoginInteractorTests.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

@testable import iScream
import Testing
import Foundation

struct LoginInteractorTests {

    var mockUserService: MockUserService
    let router: LoginRouter
    let interactor: LoginInteractor
    let id = UUID()
    let authId = UUID()
    let testUUID = UUID()
    init() throws {
        mockUserService = MockUserService()

        mockUserService.mockProfile = Profile(id: id,
                                              userName: "McTest",
                                              type: .parent,
                                              points: 1000,
                                              negativePoints: -100,
                                              parentId: nil,
                                              authId: authId,
                                              children: [],
                                              managedBounties: [],
                                              bounties: [])
        router = LoginRouter()
        interactor = LoginInteractor(entity: LoginEntity(), services: [mockUserService, DefaultUserValidationService()])!
    }

    @Test("POSITIVE - LoginInteractor - testEmailValidation",
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
        #expect(interactor.isValidEmail(email: email) == result)
    }

    @Test("POSITIVE - LoginInteractor - testPasswordValidation",
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
        #expect(interactor.isValidPassword(password: password) == result)
    }

    @Test("POSITIVE - LoginInteractor - Login") func testLoginSuccess() async throws {
        mockUserService.shouldFailLogin = false
        await #expect(throws: Never.self) {
            let profile = try await interactor.loginUser(email: "test@test.test", password: "ABCD1234_")
            #expect(profile.id == id)
            #expect(profile.userName == "McTest")
            #expect(profile.type == .parent)
            #expect(profile.points == 1000)
            #expect(profile.negativePoints == -100)
            #expect(profile.parentId == nil)
            #expect(profile.authId == authId)
            #expect(profile.children == [])
            #expect(profile.managedBounties == [])
            #expect(profile.bounties == [])
        }
    }

    @Test("POSITIVE - LoginInteractor - Login") func testLoginFails() async throws {
        mockUserService.shouldFailLogin = true
        await #expect(throws: TestError.self) {
            try await interactor.loginUser(email: "test@test.test", password: "ABCD")
        }
    }
}
