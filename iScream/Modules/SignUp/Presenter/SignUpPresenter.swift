//
//  SignUpPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import SwiftUI

protocol SignUpPresenterProtocol: GenericPresenter {
    var email: String { get set }
    var password: String { get set }
    var userName: String { get set }
    var validationPassed: Bool { get }

    var isLoading: Bool { get set }
    var errorShown: Bool { get set }
    var signupError: Error? { get set }

    // TODO: Test this
    func signUp() async throws
}

@Observable
class SignUpPresenter: GenericPresenterImp<SignUpInteractor, SignUpRouter>,
                       SignUpPresenterProtocol, Observable {

    var email: String = ""
    var password: String = ""
    var userName: String = ""
    var validationPassed: Bool = false

    var isLoading: Bool = false
    var errorShown: Bool = false
    var signupError: Error?

    func isValidEmail() -> String {
        formValidation()
        return interactor.isValidEmail(email: email)
    }

    func isValidPassword() -> String {
        formValidation()
        return interactor.isValidPassword(password: password)
    }

    func isValidNickName() -> String {
        formValidation()
        return interactor.isValidNickName(nickname: userName)
    }

    private func formValidation() {
        validationPassed = interactor.isValidEmail(email: email) == "" &&
        interactor.isValidPassword(password: password) == "" &&
        interactor.isValidNickName(nickname: userName) == ""
    }

// TODO: Test this
    func signUp() async throws {
        try await interactor.signUp(email: email, password: password, nickname: userName)
    }
}
