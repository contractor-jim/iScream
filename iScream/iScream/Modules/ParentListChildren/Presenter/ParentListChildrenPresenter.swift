//
//  ParentListChildrenPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

protocol ParentListChildrenPresenter {
    func fetch()
    var user: User? { get }
}

@Observable
class ParentListChildrenPresenterImp: ParentListChildrenPresenter, Observable {
    // ViperC conformity
    var interactor: ParentListChildrenInteractor!
    var router: ParentListChildrenRouter!

    var user: User?

    init(interactor: ParentListChildrenInteractor, router: ParentListChildrenRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() {
        user = interactor.fetchMyUser()
    }
}
