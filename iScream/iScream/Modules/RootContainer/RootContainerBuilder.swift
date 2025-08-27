//
//  RootContainerBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import Swinject

protocol RootContainerBuilder {
    func buildRootContainerView() -> AnyView
}

class RootContainerDefaultBuilder: RootContainerBuilder {

    let container = Container(parent: SharedDependancyContainerBuilder.defaultContainer)

    func buildRootContainerView() -> AnyView {
        container.register(RootContainerEntity.self) { c in
            RootContainerEntityImp()
        }

        container.register(RootContainerInteractor.self) { c in
            RootContainerInteractorImp(entity: c.resolve(RootContainerEntity.self)!)
        }

        container.register(RootContainerRouter.self) { c in
            RootContainerRouterImp()
        }

        container.register(RootContainerPresenter.self) { c in
            RootContainerPresenterImp(interactor: c.resolve(RootContainerInteractor.self)!,
                router: c.resolve(RootContainerRouter.self)!)
        }

        container.register(RootContainerView.self) { c in
            RootContainerView(presenter: c.resolve(RootContainerPresenter.self)!)
        }
        // TODO: Wrapping this view in an anyview causes a opaque type perhaps generics is a better way to go here
        return AnyView(container.resolve(RootContainerView.self)!)
    }
}
