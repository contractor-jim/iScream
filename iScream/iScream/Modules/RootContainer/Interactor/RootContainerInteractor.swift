//
//  RootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerInteractor {
    var entity: RootContainerEntity! { get }
    var userService: UserService! { get set }

    init(entity: RootContainerEntity,
         userService: UserService)

    func fetchMyUser() async -> User
}

class RootContainerInteractorImp: RootContainerInteractor {
    let entity: RootContainerEntity!
    var userService: UserService!
    // TODO: Test this
    required init(entity: any RootContainerEntity,
                  userService: UserService) {
        self.entity = entity
        self.userService = userService
    }
    // TODO: Test this
    func fetchMyUser() async -> User {
        return await userService.getUser()
    }
}
