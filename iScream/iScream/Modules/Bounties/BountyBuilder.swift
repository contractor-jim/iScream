//
//  BountyBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI
import Swinject

protocol BountyBuilder {
    func buildBountyView() -> AnyView
}

class BountyDefaultBuilder: BountyBuilder {

    let container = Container(parent: SharedDependancyContainerBuilder.defaultContainer)

    func buildBountyView() -> AnyView {
        container.register(BountyEntity.self) { c in
            BountyEntityImp()
        }

        container.register(BountyInteractor.self) { c in
            BountyInteractorImp(entity: c.resolve(BountyEntity.self)!)
        }

        container.register(BountyRouter.self) { c in
            BountyRouterImp()
        }

        container.register(BountyPresenter.self) { c in
            BountyPresenterImp(interactor: c.resolve(BountyInteractor.self)!,
                router: c.resolve(BountyRouter.self)!)
        }

        container.register(BountyView.self) { c in
            BountyView(presenter: c.resolve(BountyPresenter.self)!)
        }
        // TODO: Wrapping this view in an anyview causes a opaque type perhaps generics is a better way to go here
        return AnyView(container.resolve(BountyView.self)!)
    }
}
