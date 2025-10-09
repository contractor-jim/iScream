//
//  LoginPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

import SwiftUI

protocol LoginPresenterProtocol: GenericPresenter {
    var email: String { get set }
    var password: String { get set }

    // TODO: Test this
    func showSignUpModule()
}

@Observable
class LoginPresenter: GenericPresenterImp<LoginInteractor, LoginRouter>,
                      LoginPresenterProtocol, Observable {
    var email: String = ""
    var password: String = ""
    var showSignUp: Bool = false
    var signupUserName: String = ""

    // TODO: Test this
    func isValidEmail() -> String {
        return interactor.isValidEmail(email: email)
    }

    // TODO: Test this
    func isValidPassword() -> String {
        return interactor.isValidPassword(password: password)
    }

    // TODO: Test this
    func showSignUpModule() {
        showSignUp = true
    }
}
