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
    func getPositivePoints() -> Int
    func getNegativePoints() -> Int
}

@Observable
class ChildDashboardPresenterImp: ChildDashboardPresenter, Observable {
    // ViperC conformity
    var interactor: ChildDashboardInteractor!
    var router: ChildDashboardRouter!
    var user: User?
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    required init(interactor: ChildDashboardInteractor, router: ChildDashboardRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
    }
    // TODO: Test this
    func getPositivePoints() -> Int {
        return 500
    }
    // TODO: Test this
    func getNegativePoints() -> Int {
        return 40
    }
}
