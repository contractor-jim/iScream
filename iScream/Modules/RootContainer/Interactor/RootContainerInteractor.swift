//
//  RootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerInteractorProtocol: GenericInteractor {
    func fetchMyUser() async -> User?
}

class RootContainerInteractor: GenericInteractorImp<RootContainerEntity>, RootContainerInteractorProtocol {
    var userService: (any UserService)?

    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        self.userService = services.lazy.compactMap { $0 as? any UserService }.first
        if self.userService == nil {
            return nil
        }
        super.init(entity: entity, services: services)
    }

    func fetchMyUser() async -> User? {
        do {
            return try await userService!.getUser()
        } catch {
            return nil
        }
    }
}
