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

    let container = Container(parent: AppServiceBuilder.defaultContainer)

    func buildBountyView() -> AnyView {
        container.register(BountyEntity.self) { _ in
            BountyEntityImp()
        }

        container.register(BountyInteractor.self) { c in
            let userService = self.container.resolve(DefaultUserService.self)!
            return BountyInteractorImp(entity: c.resolve(BountyEntity.self)!,
                                userService: userService)
        }

        container.register(BountyRouter.self) { _ in
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
