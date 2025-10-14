//
//  ChildDashboardViewBuilder.swift
//  iScream
//
//  Created by james Woodbridge on 14/10/2025.
//

extension ViperContainerBuilder {
    static func buildLoginView() -> LoginView {
        return ViperContainerBuilder().buildContainerView(
            view: LoginView.self,
            interactor: LoginInteractor.self,
            presenter: LoginPresenter.self,
            entity: LoginEntity.self,
            router: LoginRouter.self,
            services: [DefaultUserService.self,
                       DefaultUserValidationService.self])
    }
}
