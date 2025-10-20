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
        interactor = LoginInteractor(entity: LoginEntity(), services: [mockUserService, DefaultUserValidationService()])!
        presenter = LoginPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - user can display signup screen") func testShowUserSignUp() throws {
        presenter.showSignUpModule()
        try #require(presenter.showSignUp == true)
    }

    @Test("POSITIVE - LoginPresenter - testEmailValidation",
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
        presenter.password = "ABCDabcd1234_@"
        #expect(presenter.isValidEmail() == result)
        #expect(presenter.validationPassed == (result == "") )
    }

    @Test("POSITIVE - LoginPresenter - testPasswordValidation",
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
    func testPasswordValidation_ReturnsCountOf3(
        password: String,
        result: String
    ) async throws {
        presenter.email = "test@test.test"
        presenter.password = password
        #expect(presenter.isValidPassword() == result)
        #expect(presenter.validationPassed == (result == "") )
    }
// TODO: The validation on the password is still incorrect fix this in a later bug ticket
    @Test("POSITIVE - LoginPresenter - testFormValidation",
          arguments: [
            (email: "",
             password: "",
             result: false),

            (email: "test@test.test",
             password: "",
             result: false),

            (email: "test@test.test",
             password: "ABCD1234_",
             result: true),

            (email: "testtrue@test.test",
             password: "Abcd1234@",
             result: true),

            (email: "test@test",
             password: "ABCD1234_",
             result: false),

            (email: "test@test.com",
             password: "ABCDbc",
             result: false),

            (email: "test@test.com",
             password: "ABCDbc",
             result: false),

            (email: "test@test.com",
             password: "ABCDbc12",
             result: true)
    ])
    func testFormValidation(
        email: String,
        password: String,
        result: Bool
    ) async throws {
        presenter.email = email
        presenter.password = password
        presenter.formValidation()
        #expect(presenter.validationPassed == result)
    }

    @Test("POSITIVE - LoginPresenter - Login") func testLoginSuccess() async throws {
        presenter.email = "test@test.test"
        presenter.password = "ABCD1234_"
        mockUserService.shouldFailLogin = false
        await #expect(throws: Never.self) {
            try await presenter.loginUser()
            #expect(presenter.errorShown == false)
            #expect(presenter.loginError == nil)
            #expect(presenter.isLoading == true)
        }
    }

    @Test("POSITIVE - LoginPresenter - Login") func testLoginFails() async throws {
        presenter.email = "test@test.test"
        presenter.password = "ABCD"
        mockUserService.shouldFailLogin = true
        await #expect(throws: TestError.self) {
            try await presenter.loginUser()
            #expect(presenter.errorShown == true)
            let testError = presenter.loginError as? TestError
            #expect(testError == .loginError("Errr"))
            #expect(presenter.isLoading == true)
        }
    }
}
