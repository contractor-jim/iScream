//
//  ChildDashboardRouter.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI

protocol ChildDashboardRouter {
    var nav: NavigationPath { get set }
}

class ChildDashboardRouterImp: ChildDashboardRouter {
    var nav = NavigationPath()
}
