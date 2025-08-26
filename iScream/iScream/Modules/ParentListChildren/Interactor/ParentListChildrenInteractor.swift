//
//  ParentListChildrenInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol ParentListChildrenInteractor {
    init(entity: ParentListChildrenEntity)
    var entity: ParentListChildrenEntity! { get }
}

class ParentListChildrenInteractorImp: ParentListChildrenInteractor {
    let entity: ParentListChildrenEntity!

    required init(entity: any ParentListChildrenEntity) {
        self.entity = entity
    }
}
