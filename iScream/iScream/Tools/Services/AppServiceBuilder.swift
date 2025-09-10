//
//  AppServiceBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import Foundation
import Swinject

class AppServiceBuilder {

    fileprivate struct Static {
        static var sharedContainer: Container?
    }

    static var defaultContainer: Container {
        Static.sharedContainer = Container { container in
            // TODO: Test this
            container.register(DefaultUserService.self) { _ in
                return DefaultUserService()
            }
        }

        return Static.sharedContainer!
    }
}
