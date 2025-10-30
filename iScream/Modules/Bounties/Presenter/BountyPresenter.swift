//
//  BountyPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

protocol BountyPresenterProtocol: GenericPresenter {
    var navPath: Binding<NavigationPath> { get }
    func fetch() async throws
}

@Observable
class BountyPresenter: GenericPresenterImp<BountyInteractor, BountyRouter>,
                       BountyPresenterProtocol, Observable {
    var profile: Profile?
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    func fetch() async throws {
        profile = try await interactor.fetchMyUserProfile()
    }
}
