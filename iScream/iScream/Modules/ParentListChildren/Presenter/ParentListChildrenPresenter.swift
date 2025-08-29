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
    // TODO: Test this
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    var user: User?

    // TODO: Test this
    init(interactor: ParentListChildrenInteractor, router: ParentListChildrenRouter) {
        self.interactor = interactor
        self.router = router
    }
    // TODO: Test this
    func fetch() async {
        user = await interactor.fetchMyUser()
    }
    // TODO: Test this
    func navigateChildDetailView(user: User) {
        router.navigateChildDetailView(user: user)
    }
}
