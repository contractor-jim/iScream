//
//  GenericViperContainerBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

import Swinject

protocol ViperContainerBuilderProtocol {
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
// TODO: Test this
class ViperContainerBuilder: ViperContainerBuilderProtocol {

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
            // Append services requested for the interactor
            var interactorServices: [S] = []
            for serviceType in services {
                if let service = self.container.resolve(serviceType.self) {
                    interactorServices.append(service)
                }
            }
            /*
            * Initialse the Interactor with both services and the entity present. This initializer can fail.
            * This is intentional to stop misuse when services are not correctly passed on and initialised
            */
            return interactor.init(entity: c.resolve(entity.self)!, services: interactorServices)!
        }

        container.register(router.self) { _ in
            router.init()
        }

        container.register(presenter.self) { c in
            /*
            * This initializer can fail.
            * This is intentional to stop misuse when services and router/interactor mismatch when
            * not correctly passed on and initialised.
            */
            presenter.init(interactor: c.resolve(interactor.self)!,
                           router: c.resolve(router.self)!)!
        }

        container.register(view.self) { c in
            view.init(presenter: c.resolve(presenter.self)!)
        }

        return container.resolve(view.self)!
    }
}
