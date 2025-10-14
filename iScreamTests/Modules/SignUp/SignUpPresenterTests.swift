//
//  SignUpPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

@testable import iScream
import Testing
import Foundation

struct SignUpPresenterTests {

    var mockUserService: MockUserService
    let router: SignUpRouter
    let interactor: SignUpInteractor
    let presenter: SignUpPresenter

    init() throws {
        mockUserService = MockUserService()
        router = SignUpRouter()
        interactor = SignUpInteractor(entity: SignUpEntity(), services: [mockUserService, DefaultUserValidationService()])!
        presenter = SignUpPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - SignUpPresenter - testEmailValidation",
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

    @Test("POSITIVE - SignUpPresenter - testPasswordValidation",
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

    @Test("POSITIVE - SignUpPresenter - testSignUpNicknameValidation",
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
    func testEmailValidation(
        nickname: String,
        result: String
    ) async throws {
        presenter.userName = nickname
        #expect(presenter.isValidNickName() == result)
    }

    @Test("POSITIVE - SignUpPresenter - testFormValidation",
          arguments: [
            (email: "",
             password: "",
             userName: "",
             result: false),

            (email: "test@test.test",
             password: "",
             userName: "",
             result: false),

            (email: "test@test.test",
             password: "ABCD1234_",
             userName: "",
             result: false),

            (email: "testtrue@test.test",
             password: "Abcd1234_",
             userName: "Alan",
             result: true),

            (email: "test@test",
             password: "ABCD1234_",
             userName: "Alan",
             result: false),

            (email: "test@test.com",
             password: "ABCDbc",
             userName: "Alan",
             result: false),

            (email: "test@test.com",
             password: "ABCDbc",
             userName: "A",
             result: false),

            (email: "test@test.com",
             password: "ABCDbc12",
             userName: "A",
             result: false)
    ])
    func testEmailValidation_ReturnsCountOf3(
        email: String,
        password: String,
        userName: String,
        result: Bool
    ) async throws {
        presenter.email = email
        presenter.password = password
        presenter.userName = userName
        #expect(presenter.validationPassed == result)
    }
}
