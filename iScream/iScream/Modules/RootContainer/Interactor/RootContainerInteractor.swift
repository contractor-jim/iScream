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

class RootContainerInteractorImp<U: UserService>: GenericInteractorImp<RootContainerEntityImp>, RootContainerInteractor {
    required init<T>(entity: T, userService: (any UserService)) where T: GenericEntity {
        super.init(entity: entity, userService: userService)
    }

    func fetchMyUser() async -> User {
        return await userService.getUser()
    }
}
