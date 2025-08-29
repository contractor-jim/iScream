//
//  ParentListChildrenRouter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol ParentListChildrenRouter {
    var nav: NavigationPath { get set }

    func navigateChildDetailView(user: User)
}

@Observable
class ParentListChildrenRouterImp: ParentListChildrenRouter {
    var nav = NavigationPath()
    // TODO: Test this
    func navigateChildDetailView(user: User) {
        nav.append(user)
    }
}
