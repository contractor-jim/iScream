//
//  ParentListChildrenPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

protocol ParentListChildrenPresenter { }

@Observable
class ParentListChildrenPresenterImp: ParentListChildrenPresenter, Observable {
    var interactor: ParentListChildrenInteractor!
    var router: ParentListChildrenRouter!

    init(interactor: ParentListChildrenInteractor, router: ParentListChildrenRouter) {
        self.interactor = interactor
        self.router = router
    }
}
