//
//  SignUpInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import SwiftUI

protocol SignUpInteractorProtocol: GenericInteractor { }

class SignUpInteractor: GenericInteractorImp<SignUpEntity>, SignUpInteractorProtocol {

    var userService: (any UserService)?
    // var userValidationService: (any DefaultUserValidationService)?

    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        self.userService = services.lazy.compactMap { $0 as? any UserService }.first
        // self.userValidationService = services.lazy.compactMap { $0 as? any DefaultUserValidationService }.first

        if self.userService == nil /* || self.userValidationService == nil */ {
            return nil
        }
        super.init(entity: entity, services: services)
    }

}
