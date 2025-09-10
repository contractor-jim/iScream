//
//  BountyRouter.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

protocol BountyRouterProtocol: GenericRouter {
    var nav: NavigationPath { get set }
}

final class BountyRouter: BountyRouterProtocol {
    var nav = NavigationPath()
}
