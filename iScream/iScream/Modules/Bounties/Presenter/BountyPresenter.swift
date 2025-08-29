//
//  BountyPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI
import SwiftData

protocol BountyPresenter {
    var user: User? { get }
    var navPath: Binding<NavigationPath> { get }
    
    func fetch() async
}

@Observable
class BountyPresenterImp: BountyPresenter, Observable {
    var interactor: BountyInteractor!
    var router: BountyRouter!
    // TODO: Test this
    var navPath: Binding<NavigationPath> {
        Binding(get: { self.router.nav }, set: { self.router.nav = $0 })
    }
    
    var user: User?
    // TODO: Test this
    init(interactor: BountyInteractor, router: BountyRouter) {
        self.interactor = interactor
        self.router = router
    }
    // TODO: Test this
    func fetch() async {
        user = await interactor.fetchMyUser()
    }
}
