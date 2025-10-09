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

    func isValidEmail() -> String {
        // TODO: This should be passsed in as a dependancy
        return UserValidationService.defaultUserValidationService.isValidEmail(email: email)
    }
    // TODO: This needs to be shared as in some common lib
    func isValidPassword() -> String {
        return UserValidationService.defaultUserValidationService.isValidPassword(password: password)
    }

    // TODO: Test this
    func showSignUpModule() {
        showSignUp = true
    }
}
