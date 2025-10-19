//
//  RootContainerViewBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 14/10/2025.
//

extension ViperContainerBuilder {
    static func buildRootContainerViewBuilder() -> RootContainerView {
        return ViperContainerBuilder().buildContainerView(
            view: RootContainerView.self,
            interactor: RootContainerInteractor.self,
            presenter: RootContainerPresenter.self,
            entity: RootContainerEntity.self,
            router: RootContainerRouter.self,
            services: [DefaultUserService.self])
    }
}
