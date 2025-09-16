//
//  ParentListChildrenInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

protocol ParentListChildrenInteractorProtocol: GenericInteractor {
    func fetchMyUser() async -> User?
}

class ParentListChildrenInteractor: GenericInteractorImp<ParentListChildrenEntity>, ParentListChildrenInteractorProtocol {
    var userService: (any UserService)?
    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        self.userService = services.lazy.compactMap { $0 as? any UserService }.first
        if self.userService == nil {
            return nil
        }
        super.init(entity: entity, services: services)
    }
    // TODO: test this
    func fetchMyUser() async -> User? {
        do {
            return try await userService!.getUser()
        } catch {
            return nil
        }
    }
}
