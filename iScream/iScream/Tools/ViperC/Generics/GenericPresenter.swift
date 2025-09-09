//
//  GenericPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

protocol GenericPresenter {
    init<I, R>(interactor: I, router: R) where I: GenericInteractor, R: GenericRouter
}

class GenericPresenterImp<Interactor, Router>: GenericPresenter {
    var interactor: Interactor
    var router: Router
    required  init<I, R>(interactor: I, router: R) where I: GenericInteractor, R: GenericRouter {
        // TODO: GENERICS Still not happy with this
        self.interactor = interactor as! Interactor
        self.router = router as! Router
    }
}
