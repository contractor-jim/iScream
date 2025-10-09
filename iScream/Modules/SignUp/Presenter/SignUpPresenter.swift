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
}

@Observable
class SignUpPresenter: GenericPresenterImp<SignUpInteractor, SignUpRouter>,
                       SignUpPresenterProtocol, Observable {

    var email: String = ""
    var password: String = ""
    var userName: String = ""

    // TODO: Test this
    func isValidEmail() -> String {
        return interactor.isValidEmail(email: email)
    }

    // TODO: Test this
    func isValidPassword() -> String {
        return interactor.isValidPassword(password: password)
    }

    // TODO: Test this
    func isValidNickName() -> String {
        return interactor.isValidNickName(nickname: userName)
    }
}
