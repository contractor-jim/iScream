//
//  SharedDependancyContainerBuilder.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import Foundation
import Swinject

class SharedDependancyContainerBuilder {

    fileprivate struct Static {
        static var sharedContainer: Container?
    }

    static var defaultContainer: Container {
        Static.sharedContainer = Container { _ in
            // TODO: Register shared dependacies
        }

        return Static.sharedContainer!
    }
}
