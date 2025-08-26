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

    public func getFirstView() -> AnyView {
        return buildSignInModule()
    }

    private func buildSignInModule() -> AnyView {
        return RootContainerDefaultBuilder().buildRootContainerView()
    }
}
