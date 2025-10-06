//
//  LoginInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

import SwiftUI

protocol LoginInteractorProtocol: GenericInteractor {

}

class LoginInteractor: GenericInteractorImp<LoginEntity>, LoginInteractorProtocol {
//    var userService: (any UserService)?
//
//    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
//        self.userService = services.lazy.compactMap { $0 as? any UserService }.first
//        if self.userService == nil {
//            return nil
//        }
//        super.init(entity: entity, services: services)
//    }
//
//    func fetchMyUser() async -> User? {
//        do {
//            return try await userService!.getUser()
//        } catch {
//            return nil
//        }
//    }
}
