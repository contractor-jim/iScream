//
//  BountyPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

protocol BountyPresenterProtocol: GenericPresenter {
    var user: User? { get }
    var navPath: Binding<NavigationPath> { get }
    func fetch() async
}

@Observable
class BountyPresenter: GenericPresenterImp<BountyInteractor, BountyRouter>,
                       BountyPresenterProtocol, Observable {
    var user: User?
    // TODO: Test this
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }

    // TODO: Test this
    func fetch() async {
        user = await interactor.fetchMyUser()
    }
}
