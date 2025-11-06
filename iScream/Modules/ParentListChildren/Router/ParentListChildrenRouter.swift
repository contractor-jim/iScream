//
//  ParentListChildrenRouter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol ParentListChildrenRouterProtocol: GenericRouter {
    var nav: NavigationPath { get set }
    func navigateChildDetailView(profile: Profile)
}

final class ParentListChildrenRouter: ParentListChildrenRouterProtocol {
    var nav = NavigationPath()

    func navigateChildDetailView(profile: Profile) {
        nav.append(profile)
    }
}
