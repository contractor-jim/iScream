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

    func showSignUpModule()
}

@Observable
class LoginPresenter: GenericPresenterImp<LoginInteractor, LoginRouter>,
                      LoginPresenterProtocol, Observable {
    var email: String = ""
    var password: String = ""
    var showSignUp: Bool = false
    var signupUserName: String = ""

    func isValidEmail() -> String {
        return interactor.isValidEmail(email: email)
    }

    func isValidPassword() -> String {
        return interactor.isValidPassword(password: password)
    }

    func showSignUpModule() {
        showSignUp = true
    }
}
