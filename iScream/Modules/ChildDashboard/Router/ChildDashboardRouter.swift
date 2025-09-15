//
//  ChildDashboardRouter.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI

protocol ChildDashboardRouterProtocol: GenericRouter {
    var nav: NavigationPath { get set }
}

final class ChildDashboardRouter: ChildDashboardRouterProtocol {
    var nav = NavigationPath()
}
