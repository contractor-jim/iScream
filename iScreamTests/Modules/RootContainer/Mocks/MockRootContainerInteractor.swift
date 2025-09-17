//
//  MockRootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream

class MockRootContainerInteractor: RootContainerInteractor {

    var didCallFetchMyuser = false

    override func fetchMyUser() async -> User? {
        didCallFetchMyuser = true
        do {
            return try await userService!.getUser()
        } catch {
            return nil
        }
    }
}
