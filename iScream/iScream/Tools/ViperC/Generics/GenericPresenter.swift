//
//  GenericPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

protocol GenericPresenter {
    init?<I, R>(interactor: I, router: R) where I: GenericInteractor, R: GenericRouter
}

class GenericPresenterImp<Interactor, Router>: GenericPresenter {
    var interactor: Interactor
    var router: Router
    required  init?<I, R>(interactor: I, router: R) where I: GenericInteractor, R: GenericRouter {
        guard let interactor = interactor as? Interactor, let router = router as? Router else { return nil }
        self.interactor = interactor
        self.router = router
    }
}
