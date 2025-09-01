//
//  ParentListChildrenPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

protocol ParentListChildrenPresenter {
    var user: User? { get }
    var navPath: Binding<NavigationPath> { get }

    func fetch() async
    func navigateChildDetailView(user: User)
}

@Observable
class ParentListChildrenPresenterImp: ParentListChildrenPresenter, Observable {
    // ViperC conformity
    var interactor: ParentListChildrenInteractor!
    var router: ParentListChildrenRouter!
    var user: User?

    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    init(interactor: ParentListChildrenInteractor, router: ParentListChildrenRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
    }

    func navigateChildDetailView(user: User) {
        router.navigateChildDetailView(user: user)
    }
}
