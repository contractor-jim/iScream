//
//  GenericInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

protocol GenericInteractor {
    init<T>(entity: T) where T: GenericEntity
}

class GenericInteractorImp<Entity>: GenericInteractor {
    var entity: Entity
    required init<T>(entity: T) where T: GenericEntity {
        // TODO: GENERICS Still not happy with this
        self.entity = entity as! Entity
    }
}
