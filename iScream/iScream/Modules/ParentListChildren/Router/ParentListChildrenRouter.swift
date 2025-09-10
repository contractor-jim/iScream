//
//  ParentListChildrenRouter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol ParentListChildrenRouterProtocol: GenericRouter {
    var nav: NavigationPath { get set }
    func navigateChildDetailView(user: User)
}

final class ParentListChildrenRouter: ParentListChildrenRouterProtocol {
    var nav = NavigationPath()

    func navigateChildDetailView(user: User) {
        nav.append(user)
    }
}
