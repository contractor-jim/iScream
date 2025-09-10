//
//  GenericViperContainerBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

import SwiftUI
import Swinject

protocol GenericViperContainerBuilder {
    func buildContainerView<V: GenericView,
                                I: GenericInteractor,
                                P: GenericPresenter,
                                E: GenericEntity,
                                R: GenericRouter,
                                S: GenericService>(
        view: V.Type,
        interactor: I.Type,
        presenter: P.Type,
        entity: E.Type,
        router: R.Type,
        services: [S.Type]) -> V
}

class GenericViperContainerBuilderImp: GenericViperContainerBuilder {

    let container = Container(parent: AppServiceBuilder.defaultContainer)

    func buildContainerView<V: GenericView,
                                I: GenericInteractor,
                                P: GenericPresenter,
                                E: GenericEntity,
                                R: GenericRouter,
                                S: GenericService>(
        view: V.Type,
        interactor: I.Type,
        presenter: P.Type,
        entity: E.Type,
        router: R.Type,
        services: [S.Type]) -> V {

        container.register(entity.self) { _ in
            entity.init()
        }

        container.register(interactor.self) { c in
            // TODO: We want to pass a list of types maybe as tuples to instatiate as part of interactor intislisation
//            guard let userService = self.container.resolve((any UserService).self)! as? DefaultUserService else {
//                fatalError()
//            }
            var interactorServices: [S] = []
            for serviceType in services {
                print("Looking for service \(serviceType)")
                if var service = self.container.resolve(serviceType.self) {
                    interactorServices.append(service)
                }
            }
            return interactor.init(entity: c.resolve(entity.self)!, services: interactorServices)
        }

        container.register(router.self) { _ in
            router.init()
        }

        container.register(presenter.self) { c in
            presenter.init(interactor: c.resolve(interactor.self)!,
                           router: c.resolve(router.self)!)
        }

        container.register(view.self) { c in
            view.init(presenter: c.resolve(presenter.self)!)
        }

        return container.resolve(view.self)!
    }
}
