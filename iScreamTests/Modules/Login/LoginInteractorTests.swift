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
                                              bounties: [],
                                              dataPoints: [],
                                              achievements: [])
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
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( $@$!%*#?& )"),

            (password: "12343",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( $@$!%*#?& )"),

            (password: "*£$£@$£$@£",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( $@$!%*#?& )"),

            (password: "abc34@",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( $@$!%*#?& )"),

            (password: "abc34@",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( $@$!%*#?& )"),

            (password: "Abc34@",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( $@$!%*#?& )"),

            (password: "ValidPassword1@",
             result: ""),

            (password: "ValidPassword2$",
             result: ""),

            (password: "ValidPa4!",
             result: ""),

            (password: "ValidPassword2%",
             result: ""),

            (password: "ValidPassword2*",
             result: ""),

            (password: "ValidPassword2?",
             result: ""),

            (password: "ValidPassword2&",
             result: ""),

            (password: "ValidPassword2#",
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
        async #expect(throws: Never.self) {
            try await interactor.loginUser(email: "test@test.test", password: "ABcd1234?")
        }
    }

    @Test("NEGATIVE - LoginInteractor - Login") func testLoginFails() async throws {
        mockUserService.shouldFailLogin = true
        await #expect(throws: TestError.self) {
            try await interactor.loginUser(email: "test@test.test", password: "ABCD")
        }
    }
}
