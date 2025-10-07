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
    var signupUserName: String { get set }

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

    // TODO: This needs to be shared as in some common lib
    func isValidEmail() -> String {
        if email.isEmpty {
            return String(localized: .validationMissingEmailMessage)
        }

        let regex = "^[A-Z0-9a-z._%+-]{1,}@[A-Za-z0-9-]{1,}(\\.[A-Za-z]{2,15}){1,2}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: email) {
            return String(localized: .validationEmailIncorrectMessage)
        }

        return ""
    }
    // TODO: This needs to be shared as in some common lib
    func isValidPassword() -> String {
        if password.isEmpty {
            return String(localized: .validationMissingPasswordMessage)
        }

        let regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: password) {
            return String(localized: .validationPasswordIncorrectMessage)
        }

        return ""
    }

    // TODO: This needs to be shared as in some common lib
    func isValidNickName() -> String {
        if signupUserName.isEmpty {
            return String(localized: .validationMissingNicknameMessage)
        }

        let regex = "^[A-Za-z]{2,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: signupUserName) {
            // TODO: Need to make this more descriptive
            return String(localized: .validationIncorrectNicknameMessage)
        }

        return ""
    }

    // TODO: Test this
    func showSignUpModule() {
        showSignUp = true
    }
}
