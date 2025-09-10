//
//  StartupManager.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import Foundation
import Swinject
import SwiftUI

protocol StartupManagerProtocol {
    func getFirstView() -> RootContainerView
}

class StartupManager: StartupManagerProtocol {
    public static var `default` = StartupManager()

    public func getFirstView() -> RootContainerView {
        return buildSignInModule()
    }
    // TODO: Test this
    private func buildSignInModule() -> RootContainerView {
        ViperContainerBuilder().buildContainerView(
            view: RootContainerView.self,
            interactor: RootContainerInteractor.self,
            presenter: RootContainerPresenter.self,
            entity: RootContainerEntity.self,
            router: RootContainerRouter.self,
            services: [DefaultUserService.self])
    }
}
