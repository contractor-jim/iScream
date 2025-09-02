//
//  ChildDashboardPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI
import SwiftData

// TODO: move this further down to the model
struct IcecramPointSpread: Identifiable {
    let id = UUID()
    let title: String
    let points: Int
    let color: Color
}

protocol ChildDashboardPresenter {
    var user: User? { get }
    var navPath: Binding<NavigationPath> { get }
    var points: [IcecramPointSpread] { get }

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
    var points: [IcecramPointSpread] = []
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    required init(interactor: ChildDashboardInteractor, router: ChildDashboardRouter) {
        self.interactor = interactor
        self.router = router
        points = [
            IcecramPointSpread.init(title: String(localized: "general.good.label"), points: getPositivePoints(), color: .green),
            IcecramPointSpread.init(title: String(localized: "general.naughty.label"), points: getNegativePoints(), color: .red)
        ]
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
