//
//  ChildDashboardPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI
import SwiftData

protocol ChildDashboardPresenter {
    var user: User? { get }
    var navPath: Binding<NavigationPath> { get }
    
    func fetch() async
}

@Observable
class ChildDashboardPresenterImp: ChildDashboardPresenter, Observable {
    // ViperC conformity
    var interactor: ChildDashboardInteractor!
    var router: ChildDashboardRouter!
    // TODO: Test this
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    var user: User?
    // TODO: Test this
    required init(interactor: ChildDashboardInteractor, router: ChildDashboardRouter) {
        self.interactor = interactor
        self.router = router
    }
    // TODO: Test this
    func fetch() async {
        user = await interactor.fetchMyUser()
    }
}
