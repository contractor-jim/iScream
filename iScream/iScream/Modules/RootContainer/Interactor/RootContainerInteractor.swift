//
//  RootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerInteractor {
    func fetchMyUser() async -> User
}

class RootContainerInteractorImp: GenericInteractorImp<RootContainerEntityImp>, RootContainerInteractor {

    var userService: DefaultUserService?
    required init<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {

        // userService = services.first(where: $0.self == DefaultUserService.Type)

        for service in services {
            if let userService = service as? DefaultUserService {
                self.userService = userService
            }
            print("We loaded a service: \(service)")
        }
        super.init(entity: entity, services: services)
    }

    func fetchMyUser() async -> User {
        return await userService!.getUser()
    }
}
