//
//  StartupManager.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import Foundation
import Swinject
import SwiftUI

protocol StartupManager {
    func getFirstView() -> AnyView
}

class StartupManagerImp {
    public static var `default` = StartupManagerImp()

    public func getFirstView() -> RootContainerView {
        return buildSignInModule()
    }
    // TODO: This is named incorrectly
    private func buildSignInModule() -> RootContainerView {
        GenericViperContainerBuilderImp().buildContainerView(
            view: RootContainerView.self,
            interactor: RootContainerInteractorImp<DefaultUserService>.self,
            presenter: RootContainerPresenterImp.self,
            entity: RootContainerEntityImp.self,
            router: RootContainerRouterImp.self)
    }
}
