//
//  ChildDashboardBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI
import Swinject

protocol ChildDashboardBuilder {
    func buildChildDashboardView() -> AnyView
}

class ChildDashboardDefaultBuilder: ChildDashboardBuilder {

    let container = Container(parent: AppServiceBuilder.defaultContainer)

    func buildChildDashboardView() -> AnyView {
        container.register(ChildDashboardEntity.self) { c in
            ChildDashboardEntityImp()
        }

        container.register(ChildDashboardInteractor.self) { c in
            let userService = self.container.resolve(UserService.self)!
            return ChildDashboardInteractorImp(entity: c.resolve(ChildDashboardEntity.self)!,
                                        userService: userService)
        }

        container.register(ChildDashboardRouter.self) { c in
            ChildDashboardRouterImp()
        }

        container.register(ChildDashboardPresenter.self) { c in
            ChildDashboardPresenterImp(interactor: c.resolve(ChildDashboardInteractor.self)!,
                router: c.resolve(ChildDashboardRouter.self)!)
        }

        container.register(ChildDashboardView.self) { c in
            ChildDashboardView(presenter: c.resolve(ChildDashboardPresenter.self)!)
        }
        // TODO: Wrapping this view in an anyview causes a opaque type perhaps generics is a better way to go here
        return AnyView(container.resolve(ChildDashboardView.self)!)
    }
}
