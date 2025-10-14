//
//  SignUpViewBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 14/10/2025.
//

extension ViperContainerBuilder {
    static func buildSignUpView() -> SignUpView {
        return ViperContainerBuilder().buildContainerView(
            view: SignUpView.self,
            interactor: SignUpInteractor.self,
            presenter: SignUpPresenter.self,
            entity: SignUpEntity.self,
            router: SignUpRouter.self,
            services: [DefaultUserService.self,
                       DefaultUserValidationService.self])
    }
}
