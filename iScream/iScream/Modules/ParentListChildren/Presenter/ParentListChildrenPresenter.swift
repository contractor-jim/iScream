//
//  ParentListChildrenPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

protocol ParentListChildrenPresenterProtocol: GenericPresenter {
    func fetch() async
    func navigateChildDetailView(user: User)
}

@Observable
class ParentListChildrenPresenter: GenericPresenterImp<ParentListChildrenInteractor, ParentListChildrenRouter>,
                                    ParentListChildrenPresenterProtocol,
                                    Observable {
    var user: User?
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
    }

    func navigateChildDetailView(user: User) {
        router.navigateChildDetailView(user: user)
    }
}
