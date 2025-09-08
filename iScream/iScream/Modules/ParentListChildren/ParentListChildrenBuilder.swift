//
//  ParentListChildrenBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import Swinject

protocol ParentListChildrenBuilder {
    func buildParentListChildrenView() -> AnyView
}

class ParentListChildrenDefaultBuilder: ParentListChildrenBuilder {

    let container = Container(parent: AppServiceBuilder.defaultContainer)

    func buildParentListChildrenView() -> AnyView {

        container.register(ParentListChildrenEntity.self) { _ in
            ParentListChildrenEntityImp()
        }

        container.register(ParentListChildrenInteractor.self) { c in
            let userService = self.container.resolve(UserService.self)!
            return ParentListChildrenInteractorImp(entity: c.resolve(ParentListChildrenEntity.self)!,
                                            userService: userService)
        }

        container.register(ParentListChildrenRouter.self) { _ in
            ParentListChildrenRouterImp()
        }

        container.register(ParentListChildrenPresenter.self) { c in
            ParentListChildrenPresenterImp(interactor: c.resolve(ParentListChildrenInteractor.self)!,
                router: c.resolve(ParentListChildrenRouter.self)!)
        }

        container.register(ParentListChildrenView.self) { c in
            ParentListChildrenView(presenter: c.resolve(ParentListChildrenPresenter.self)!)
        }
        // TODO: Wrapping this view in an anyview causes a opaque type perhaps generics is a better way to go here
        return AnyView(container.resolve(ParentListChildrenView.self)!)
    }
}
