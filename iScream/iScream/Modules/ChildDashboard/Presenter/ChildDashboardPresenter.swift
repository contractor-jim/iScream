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
    func fetch() async
}

@Observable
class ChildDashboardPresenterImp: ChildDashboardPresenter, Observable {
    // ViperC conformity
    var interactor: ChildDashboardInteractor!
    var router: ChildDashboardRouter!

    var user: User?

    required init(interactor: ChildDashboardInteractor, router: ChildDashboardRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
    }
}
