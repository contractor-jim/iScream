//
//  GenericInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

protocol GenericInteractor {
    init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService
}

class GenericInteractorImp<Entity: GenericEntity>: GenericInteractor {
    var entity: Entity
    required init?<E, S>(entity: E, services: [S]) where E: GenericEntity, S: GenericService {
        guard let entity = entity as? Entity else { return nil }
        self.entity = entity
    }
}
