//
//  RootContainerInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerInteractor {
    init(entity: RootContainerEntity)
    var entity: RootContainerEntity! { get }
}

class RootContainerInteractorImp: RootContainerInteractor {
    let entity: RootContainerEntity!

    required init(entity: any RootContainerEntity) {
        self.entity = entity
    }
}
