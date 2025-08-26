//
//  RootContainerPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

protocol RootContainerPresenter { }

@Observable
class RootContainerPresenterImp: RootContainerPresenter, Observable {
    var interactor: RootContainerInteractor!
    var router: RootContainerRouter!

    init(interactor: RootContainerInteractor, router: RootContainerRouter) {
        self.interactor = interactor
        self.router = router
    }
}
