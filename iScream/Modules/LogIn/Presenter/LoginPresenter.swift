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
}

@Observable
class LoginPresenter: GenericPresenterImp<LoginInteractor, LoginRouter>,
                      LoginPresenterProtocol, Observable {
    var email: String = ""
    var password: String = ""
    // TODO: This needs to be shared as in some common lib
    // TODO: This needs to use the strings file
    func isValidEmail() -> String {
        if email.isEmpty {
            return "Missing Email"
        }

        let regex = "^[A-Z0-9a-z._%+-]{1,}@[A-Za-z0-9-]{1,}(\\.[A-Za-z]{2,15}){1,2}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: email) {
            return "Invalid Email"
        }

        return ""
    }
    // TODO: This needs to be shared as in some common lib
    // TODO: This needs to use the strings file
    func isValidPassword() -> String {
        if password.isEmpty {
            return "Missing Password"
        }

        let regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: password) {
            return "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"
        }

        return ""
    }
}
