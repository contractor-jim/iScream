//
//  RootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerInteractorProtocol: GenericInteractor {
    func fetchMyUserProfile() async throws -> Profile?
}

class RootContainerInteractor: GenericInteractorImp<RootContainerEntity>, RootContainerInteractorProtocol {
    var userService: (any UserService)?

    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        self.userService = services.lazy.compactMap { $0 as? any UserService }.first
        if self.userService == nil {
            return nil
        }
        super.init(entity: entity, services: services)
    }

    // TODO: Test this
    // TODO: Surely this could be better refactored
    func fetchMyUserProfile() async throws -> Profile? {
        print(">>> ROOT fetchMyUserProfile 1")
        // TODO: need to throw error if there is no valid user service
        guard let userService = userService,
              let userId = try await userService.getLoggedInUserId() else {
            // TODO: Add error handeling here
            print(">>> ROOT ERR  1")
            return nil
        }

        guard let profile =  try await userService.fetchProfile(userId: userId) else {
            // TODO: Add error handeling her
            print(">>> ROOT ERR  2")
            return nil
        }

        print(">>> profile \(profile)")

        return profile
    }
}
