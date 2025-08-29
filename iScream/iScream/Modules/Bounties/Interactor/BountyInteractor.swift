//
//  BountyInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

protocol BountyInteractor {
    init(entity: BountyEntity,
         userService: UserService
    )
    var entity: BountyEntity! { get }
    var userService: UserService! { get set }

    func fetchMyUser() async -> User
}

class BountyInteractorImp: BountyInteractor {
    let entity: BountyEntity!
    var userService: UserService!
    
    required init(entity: any BountyEntity,
                  userService: UserService) {
        self.entity = entity
        self.userService = userService
    }

    func fetchMyUser() async -> User {
        return await userService.getUser()
    }
}
