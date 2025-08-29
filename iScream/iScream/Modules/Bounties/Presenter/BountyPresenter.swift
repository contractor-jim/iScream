//
//  BountyPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI
import SwiftData

protocol BountyPresenter { }

@Observable
class BountyPresenterImp: BountyPresenter, Observable {
    var interactor: BountyInteractor!
    var router: BountyRouter!

    init(interactor: BountyInteractor, router: BountyRouter) {
        self.interactor = interactor
        self.router = router
    }
}
