//
//  LoginViewBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 14/10/2025.
//

extension ViperContainerBuilder {
    static func buildChildDashboardView() -> ChildDashboardView {
        return ViperContainerBuilder().buildContainerView(
            view: ChildDashboardView.self,
            interactor: ChildDashboardInteractor.self,
            presenter: ChildDashboardPresenter.self,
            entity: ChildDashboardEntity.self,
            router: ChildDashboardRouter.self,
            services: [DefaultUserService.self])
    }
}
