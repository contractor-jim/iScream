//
//  RootContainerEntity.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

protocol RootContainerEntity: Equatable { }

final class RootContainerEntityImp: RootContainerEntity { }

extension RootContainerEntityImp: Equatable {
    static func == (lhs: RootContainerEntityImp, rhs: RootContainerEntityImp) -> Bool {
        // Need to add equatable options on the entity
        true
    }
}
