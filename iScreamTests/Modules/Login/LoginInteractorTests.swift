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

    init() throws {
        mockUserService = MockUserService()
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
}
