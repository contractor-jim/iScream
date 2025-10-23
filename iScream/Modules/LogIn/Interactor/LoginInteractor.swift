//
//  LoginInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

import SwiftUI

protocol LoginInteractorProtocol: GenericInteractor {
    func loginUser(email: String, password: String) async throws -> Profile
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

    func loginUser(email: String, password: String) async throws -> Profile {
        let userId = try await userService?.loginUser(email: email, password: password)
        // TODO: This needs to be better handeld error wise
        let profile = try await userService?.fetchProfile(userId: userId!)
        // TODO: Need to handle error case when a profile doesn't return correctly
        return profile!
    }
}
