//
//  BountyViewBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 14/10/2025.
//

extension ViperContainerBuilder {
    static func buildBountyView() -> BountyView {
        return ViperContainerBuilder().buildContainerView(
            view: BountyView.self,
            interactor: BountyInteractor.self,
            presenter: BountyPresenter.self,
            entity: BountyEntity.self,
            router: BountyRouter.self,
            services: [DefaultUserService.self])
    }
}
