//
//  MockRootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream

class MockRootContainerInteractor: RootContainerInteractor {
    var entity: RootContainerEntity!
    var userService: UserService!

    var didCallFetchMyuser = false

    required init(entity: RootContainerEntity,
                  userService: UserService) {
        self.entity = entity
        self.userService = userService

    }

    func fetchMyUser() async -> User {
        didCallFetchMyuser = true
        return await userService.getUser()
    }
}
