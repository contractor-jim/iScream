
//
//  ChildDashboardInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

protocol ChildDashboardInteractor {
    init(entity: ChildDashboardEntity,
         userService: UserService)
    
    var userService: UserService! { get set }
    var entity: ChildDashboardEntity! { get }

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
