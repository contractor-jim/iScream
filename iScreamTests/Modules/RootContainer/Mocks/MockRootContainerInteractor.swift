//
//  MockRootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Foundation

class MockRootContainerInteractor: RootContainerInteractor {

    var didCallFetchMyuser = false

    override func fetchMyUserProfile() async throws -> Profile? {
        didCallFetchMyuser = true
        do {
            return try await userService!.fetchProfile()
        } catch {
            return nil
        }
    }
}
