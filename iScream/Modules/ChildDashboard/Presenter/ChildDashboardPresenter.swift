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

protocol ChildDashboardPresenterProtocol: GenericPresenter {
    var user: User? { get }
    var navPath: Binding<NavigationPath> { get }
    var points: [IcecramPointSpread] { get }
    var openBountyCount: Int { get }
    var totalBountyCount: Int { get }

    func fetch() async
    func getThisYear() -> String
}

@Observable
class ChildDashboardPresenter: GenericPresenterImp<ChildDashboardInteractor, ChildDashboardRouter>,
                               ChildDashboardPresenterProtocol, Observable {
    var user: User?
    var points: [IcecramPointSpread] = []
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    var openBountyCount: Int {
        user?.completedBounties.count ?? 0
    }

    var totalBountyCount: Int {
        (user?.completedBounties.count ?? 0) + (user?.openBounties.count ?? 0)
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
        guard let user else { return }
        points = [
            IcecramPointSpread.init(title: String(localized: "general.good.label"), points: user.iceCreamPoints, color: .green),
            IcecramPointSpread.init(title: String(localized: "general.naughty.label"), points: user.negativeIceCreamPoints, color: .red)
        ]
    }

    // TODO: We need to be able to search progress on years, pagination with db search?
    func getThisYear() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
