//
//  ChildDashboardPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI
import SwiftData

// TODO: move this further down to the model
struct IceCreamPointSpread: Identifiable {
    let id = UUID()
    let title: String
    let points: Int
    let color: Color
}

protocol ChildDashboardPresenterProtocol: GenericPresenter {
    var navPath: Binding<NavigationPath> { get }
    var points: [IceCreamPointSpread] { get }
    var openBountyCount: Int { get }
    var totalBountyCount: Int { get }

    func fetch() async throws
    func getThisYear() -> String
}

@Observable
class ChildDashboardPresenter: GenericPresenterImp<ChildDashboardInteractor, ChildDashboardRouter>,
                               ChildDashboardPresenterProtocol, Observable {
    var profile: Profile?
    var points: [IceCreamPointSpread] = []
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    var openBountyCount: Int {
        profile?.completedBounties.count ?? 0
    }

    var totalBountyCount: Int {
        (profile?.completedBounties.count ?? 0) + (profile?.openBounties.count ?? 0)
    }
    // TODO: Retest this
    func fetch() async throws {
        profile = try await interactor.fetchMyUserProfile()
        guard let profile else { return }
        // TODO: Retest this when points are re-enabled
        points = [
            IceCreamPointSpread.init(title: String(localized: "general.good.label"), points: profile.points, color: .green),
            IceCreamPointSpread.init(title: String(localized: "general.naughty.label"), points: profile.negativePoints, color: .red)
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
