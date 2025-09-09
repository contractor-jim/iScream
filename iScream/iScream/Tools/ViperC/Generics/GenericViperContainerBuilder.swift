//
//  GenericViperContainerBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

import SwiftUI
import Swinject

protocol GenericViperContainerBuilder {
    func buildContainerView<V: GenericView, I: GenericInteractor, P: GenericPresenter, E: GenericEntity, R: GenericRouter>(
        view: V.Type,
        interactor: I.Type,
        presenter: P.Type,
        entity: E.Type,
        router: R.Type) -> V
}

class GenericViperContainerBuilderImp: GenericViperContainerBuilder {

    let container = Container(parent: AppServiceBuilder.defaultContainer)

    func buildContainerView<V: GenericView, I: GenericInteractor, P: GenericPresenter, E: GenericEntity, R: GenericRouter>(
        view: V.Type,
        interactor: I.Type,
        presenter: P.Type,
        entity: E.Type,
        router: R.Type) -> V {

        container.register(entity.self) { _ in
            entity.init()
        }

        container.register(interactor.self) { c in
            // TODO: Generically specailse user service
//            guard let userService = self.container.resolve((any UserService).self)! as? DefaultUserService else {
//                fatalError()
//            }
            // TODO: Do we want the user service to be appended by default?
            return interactor.init(entity: c.resolve(entity.self)!)
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
