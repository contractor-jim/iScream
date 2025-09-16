//
//  PointData.swift
//  iScream
//
//  Created by James Woodbridge on 16/09/2025.
//

import Foundation
import SwiftData

@Model
final class PointData {
    @Attribute(.unique) var id: UUID
    var month: String
    var points: Int

    init(id: UUID,
         month: String,
         points: Int) {
        self.id = id
        self.month = month
        self.points = points
    }
}

extension PointData: Equatable {
    static func == (lhs: PointData, rhs: PointData) -> Bool {
        rhs.month == rhs.month &&
        rhs.points == rhs.points
    }
}
