//
//  BountyInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

protocol BountyInteractorProtocol: GenericInteractor {
    func fetchMyUser() async -> User
}

class BountyInteractor: GenericInteractorImp<BountyEntity>,
                        BountyInteractorProtocol {
    var userService: DefaultUserService?
    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        self.userService = services.lazy.compactMap { $0 as? DefaultUserService }.first
        if self.userService == nil {
            return nil
        }
        super.init(entity: entity, services: services)
    }

    func fetchMyUser() async -> User {
        return await userService!.getUser()
    }
}
