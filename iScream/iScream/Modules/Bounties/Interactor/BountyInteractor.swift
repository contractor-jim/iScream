//
//  BountyInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

protocol BountyInteractor {
    init(entity: BountyEntity)
    var entity: BountyEntity! { get }
}

class BountyInteractorImp: BountyInteractor {
    let entity: BountyEntity!

    required init(entity: any BountyEntity) {
        self.entity = entity
    }
}
