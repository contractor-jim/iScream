//
//  ParentListChildrenViewBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 14/10/2025.
//

extension ViperContainerBuilder {
    static func buildParentListChildrenViewBuilder() -> ParentListChildrenView {
        return ViperContainerBuilder().buildContainerView(
            view: ParentListChildrenView.self,
            interactor: ParentListChildrenInteractor.self,
            presenter: ParentListChildrenPresenter.self,
            entity: ParentListChildrenEntity.self,
            router: ParentListChildrenRouter.self,
            services: [DefaultUserService.self])
    }
}
