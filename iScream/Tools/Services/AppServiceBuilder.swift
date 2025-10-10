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

            container.register(GenericService.self, name: "DefaultUserService") { _ in
                return DefaultUserService()
            }

            container.register(GenericService.self, name: "DefaultUserValidationService") { _ in
                return DefaultUserValidationService()
            }

            container.register(GenericService.self, name: "DefaultSupaBaseService") { _ in
                return DefaultSupaBaseService()
            }
        }

        return Static.sharedContainer!
    }
}
