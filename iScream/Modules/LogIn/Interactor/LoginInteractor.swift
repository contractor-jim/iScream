//
//  LoginInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

import SwiftUI

protocol LoginInteractorProtocol: GenericInteractor {
    func loginUser(email: String, password: String) async throws
}

class LoginInteractor: GenericInteractorImp<LoginEntity>, LoginInteractorProtocol {
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
    // TODO: Test this
    func loginUser(email: String, password: String) async throws {
        try await userService?.loginUser(email: email, password: password)
    }
}
