//
//  SignUpInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import SwiftUI

protocol SignUpInteractorProtocol: GenericInteractor {
    func isValidEmail(email: String) -> String
    func isValidPassword(password: String) -> String
    func isValidNickName(nickname: String) -> String
}

class SignUpInteractor: GenericInteractorImp<SignUpEntity>, SignUpInteractorProtocol {

    private var userService: (any UserService)?
    private var userValidationService: (any UserValidationService)?

    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        self.userService = services.lazy.compactMap { $0 as? any UserService }.first
        self.userValidationService = services.lazy.compactMap { $0 as? any UserValidationService }.first

        if self.userService == nil || self.userValidationService == nil {
            return nil
        }
        super.init(entity: entity, services: services)
    }
    // TODO: Test this
    func isValidEmail(email: String) -> String {
        return userValidationService!.isValidEmail(email: email)
    }
    // TODO: Test this
    func isValidPassword(password: String) -> String {
        return userValidationService!.isValidPassword(password: password)
    }
    // TODO: Test this
    func isValidNickName(nickname: String) -> String {
        return userValidationService!.isValidNickName(userName: nickname)
    }
}
