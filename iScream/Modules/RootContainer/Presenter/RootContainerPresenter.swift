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

        if userProfile.type == .unknown {
            return 0
        }

        return userProfile.openBountiesCount
    }
}
