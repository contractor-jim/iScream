//
//  ParentListChildrenInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import Foundation

protocol ParentListChildrenInteractorProtocol: GenericInteractor {
    func fetchMyUserProfile() async throws -> Profile?
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

    func fetchMyUserProfile() async throws -> Profile? {

        guard let userService = userService,
              let profile = try await userService.fetchProfile() else {
            // TODO: Add error handeling here
            return nil
        }

        return profile
    }
}
