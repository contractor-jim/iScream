//
//  RootContainerPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerPresenterProtocol {
    var user: User? { get }
    func fetch() async
    func getBountyBadgeCount() -> Int
}

@Observable
class RootContainerPresenter: GenericPresenterImp<RootContainerInteractor, RootContainerRouter>,
                              RootContainerPresenterProtocol, Observable {
    var user: User?

    func fetch() async {
        user = await interactor.fetchMyUser()
    }

    func getBountyBadgeCount() -> Int {
        guard let user else {
            return 0
        }

        if user.type == .child {
            return user.openBounties.count
        } else if user.type == .parent {
            // TODO: Need another state called pending complete to tell the parent of bounties the child claims to have completed
            return 0
        }

        return 0
    }
}
