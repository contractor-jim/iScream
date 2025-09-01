
//
//  ChildDashboardInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

protocol ChildDashboardInteractor {
    init(entity: ChildDashboardEntity,
         userService: UserService)
    
    var entity: ChildDashboardEntity! { get }
    var userService: UserService! { get set }

    func fetchMyUser() async -> User
}

class ChildDashboardInteractorImp: ChildDashboardInteractor {
    let entity: ChildDashboardEntity!
    var userService: UserService!

    required init(entity: any ChildDashboardEntity,
                  userService: UserService) {
        self.entity = entity
        self.userService = userService
    }

    func fetchMyUser() async -> User {
        return await userService.getUser()
    }
}
