//
//  ParentListChildrenInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol ParentListChildrenInteractor {
    init(entity: ParentListChildrenEntity,
         userService: UserService)

    var entity: ParentListChildrenEntity! { get }
    var userService: UserService! { get set }
    
    func fetchMyUser() async -> User
}

class ParentListChildrenInteractorImp: ParentListChildrenInteractor {
    let entity: ParentListChildrenEntity!
    var userService: UserService!

    required init(entity: any ParentListChildrenEntity,
                  userService: UserService) {
        self.entity = entity
        self.userService = userService
    }

    func fetchMyUser() async -> User {
        return await userService.getUser()
    }
}
