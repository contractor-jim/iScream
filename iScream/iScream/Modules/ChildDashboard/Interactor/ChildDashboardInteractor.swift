//
//  ChildDashboardInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

protocol ChildDashboardInteractorProtocol: GenericInteractor {
    func fetchMyUser() async -> User
}

class ChildDashboardInteractor: GenericInteractorImp<ChildDashboardEntity>, ChildDashboardInteractorProtocol {
    var userService: (any UserService)?

    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        self.userService = services.lazy.compactMap { $0 as? any UserService }.first
        if self.userService == nil {
            return nil
        }
        super.init(entity: entity, services: services)
    }

    func fetchMyUser() async -> User {
        return await userService!.getUser()
    }
}
