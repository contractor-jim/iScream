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

    func isValidEmail() -> String {
        // TODO: This should be passsed in as a dependancy
        return UserValidationService.defaultUserValidationService.isValidEmail(email: email)
    }

    func isValidPassword() -> String {
        // TODO: This should be passsed in as a dependancy
        return UserValidationService.defaultUserValidationService.isValidPassword(password: password)
    }

    func isValidNickName() -> String {
        // TODO: This should be passsed in as a dependancy
        return UserValidationService.defaultUserValidationService.isValidNickName(userName: userName)
    }
}
