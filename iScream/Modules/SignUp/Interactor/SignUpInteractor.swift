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

    // TODO: Test this
    func signUp(email: String, password: String, nickname: String) async throws
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

    func isValidEmail(email: String) -> String {
        return userValidationService!.isValidEmail(email: email)
    }

    func isValidPassword(password: String) -> String {
        return userValidationService!.isValidPassword(password: password)
    }

    func isValidNickName(nickname: String) -> String {
        return userValidationService!.isValidNickName(userName: nickname)
    }

    // TODO: Test this
    func signUp(email: String, password: String, nickname: String) async throws {
        try await userService!.registerUser(email: email, password: password, nickname: nickname)
    }
}
