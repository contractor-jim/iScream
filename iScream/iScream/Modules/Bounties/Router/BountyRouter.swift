//
//  BountyRouter.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

protocol BountyRouter {
    var nav: NavigationPath { get set }
}

class BountyRouterImp: BountyRouter {
    var nav = NavigationPath()
}
