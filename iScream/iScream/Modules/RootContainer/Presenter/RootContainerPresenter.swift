//
//  RootContainerPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

protocol RootContainerPresenter {
    var user: User? { get }
    func fetch() async
    func getBountyBadgeCount() -> Int
}

@Observable
class RootContainerPresenterImp: RootContainerPresenter, Observable {
    var interactor: RootContainerInteractor!
    var router: RootContainerRouter!

    var user: User?

    init(interactor: RootContainerInteractor, router: RootContainerRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
    }

    func getBountyBadgeCount() -> Int {

        guard let user else {
            return 0
        }

        if user.type == .child { return user.openBounties.count }
        else if user.type == .parent {
            // TODO: Need another state called pending complete to tell the parent of bounties the child claims to have completed
            return 0
        }

        return -1
    }
}
