//
//  LoginPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

import SwiftUI

protocol LoginPresenterProtocol: GenericPresenter {
    // Form fields
    var email: String { get set }
    var password: String { get set }
    var validationPassed: Bool { get }

    // Error Handeling
    var errorShown: Bool { get set }
    var loginError: Error? { get set }

    // State change
    var isLoading: Bool { get set }

    // Actions
    func showSignUpModule()
    func loginUser() async throws
}

@Observable
class LoginPresenter: GenericPresenterImp<LoginInteractor, LoginRouter>,
                      LoginPresenterProtocol, Observable {
    var email: String = ""
    var password: String = ""
    var showSignUp: Bool = false
    var signupUserName: String = ""

    var validationPassed: Bool = false
    var isLoading: Bool = false
    var errorShown: Bool = false
    var loginError: Error?

    func isValidEmail() -> String {
        formValidation()
        return interactor.isValidEmail(email: email)
    }

    func isValidPassword() -> String {
        formValidation()
        return interactor.isValidPassword(password: password)
    }

    func showSignUpModule() {
        showSignUp = true
    }

    func formValidation() {
        validationPassed = interactor.isValidEmail(email: email) == "" &&
        interactor.isValidPassword(password: password) == ""
    }

    func loginUser() async throws {
        isLoading = true
        // TODO: Test this
        _ = try await interactor.loginUser(email: email, password: password)
        email = ""
        password = ""
    }
}
