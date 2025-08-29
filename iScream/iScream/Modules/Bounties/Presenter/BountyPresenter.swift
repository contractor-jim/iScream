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
    func fetch() async
}

@Observable
class BountyPresenterImp: BountyPresenter, Observable {
    var interactor: BountyInteractor!
    var router: BountyRouter!

    var user: User?

    init(interactor: BountyInteractor, router: BountyRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
    }
}
