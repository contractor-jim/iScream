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
    var month: Date
    var points: Int
    var user: User

    @Transient lazy var monthString: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: month)
    }()

    init(id: UUID,
         month: Date,
         points: Int,
         user: User) {
        self.id = id
        self.month = month
        self.points = points
        self.user = user
    }
}

extension PointData: Equatable {
    static func == (lhs: PointData, rhs: PointData) -> Bool {
        rhs.month == rhs.month &&
        rhs.points == rhs.points
    }
}
