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

    var userService: (any UserService)!

    public init<T: RootContainerEntity>(entity: T, userService: U) {
        self.userService = userService
        super.init(entity: entity)
    }

    // TODO: This needs to be supressed somehow and called up the stack for inheirtance
    required init<T>(entity: T) where T: GenericEntity {
        super.init(entity: entity)
        // self.entity = entity as! RootContainerEntityImp
        // fatalError("init(entity:) has not been implemented")
    }

    func fetchMyUser() async -> User {
        return await userService.getUser()
    }
}
