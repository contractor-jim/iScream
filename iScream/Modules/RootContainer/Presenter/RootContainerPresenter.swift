//
//  RootContainerPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerPresenterProtocol: GenericPresenter {
    func fetch() async
    func getBountyBadgeCount() -> Int
}

@Observable
class RootContainerPresenter: GenericPresenterImp<RootContainerInteractor, RootContainerRouter>,
                              RootContainerPresenterProtocol, Observable {
    // var user: User?
    var userProfile: Profile?
    var requiringLogIn: Bool = true

    func fetch() async {
        // user = await interactor.fetchMyUser()
        // TODO: Handle the error elegantly
        do {
            userProfile = try await interactor.fetchMyUserProfile()
        } catch { }

    }
    // TODO: Retest this
    func getBountyBadgeCount() -> Int {
        guard let userProfile else {
            return 0
        }
        // TODO: Reimplement the badge count when we add database bounties
        /*
        if user.type == UserType.child.rawValue {
            return user.openBounties.count
        } else if user.type == UserType.parent.rawValue {
            // TODO: Need another state called pending complete to tell the parent of bounties the child claims to have completed
            return 0
        }
        */
        return 0
    }
}
