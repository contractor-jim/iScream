//
//  MockRootContainerEntity.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Foundation

final class MockRootContainerEntity: RootContainerEntity {
    let mockId = UUID()
}

extension MockRootContainerEntity: Equatable {
    static func == (lhs: MockRootContainerEntity, rhs: MockRootContainerEntity) -> Bool {
        lhs.mockId == rhs.mockId
    }
}
