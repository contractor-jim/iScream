//
//  RootContainerPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerPresenterProtocol: GenericPresenter {

    // Error Handeling
    var errorShown: Bool { get set }
    var loginError: Error? { get set }

    func fetch() async throws
    func getBountyBadgeCount() -> Int
}

@Observable
class RootContainerPresenter: GenericPresenterImp<RootContainerInteractor, RootContainerRouter>,
                              RootContainerPresenterProtocol, Observable {

    var userProfile: Profile?
    var requiringLogIn: Bool = true
    var errorShown: Bool = false
    var loginError: Error?

    // TODO: Test this
    func fetch() async throws {
        do {
            userProfile = try await interactor.fetchMyUserProfile()
        } catch {
            requiringLogIn = true
            errorShown = true
            loginError = LoginError.failedToLoadProfile
        }
    }

    func getBountyBadgeCount() -> Int {
        guard let userProfile else {
            return 0
        }

        if userProfile.type == UserType.child {
            return userProfile.openBounties.count
        } else if userProfile.type == UserType.parent {
            // TODO: Need another state called pending complete to tell the parent of bounties the child claims to have completed
            return 0
        }

        return 0
    }
}
