//
//  LoginPresenterTests.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

@testable import iScream
import Testing
import Foundation

struct LoginPresenterTests {

    var mockUserService: MockUserService
    let router: LoginRouter
    let interactor: LoginInteractor
    let presenter: LoginPresenter

    init() throws {
        mockUserService = MockUserService()
        router = LoginRouter()
        interactor = LoginInteractor(entity: LoginEntity(), services: [mockUserService])!
        presenter = LoginPresenter(interactor: interactor, router: router)!
    }

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
