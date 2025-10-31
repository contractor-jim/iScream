//
//  User.swift
//  iScream
//
//  Created by James Woodbridge on 16/09/2025.
//

import Foundation
import SwiftData

@Model
final class User {

    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade, inverse: \PointData.user) var dataPoints: [PointData]
    var name: String
    var iceCreamPoints: Int
    var negativeIceCreamPoints: Int

    @Transient lazy var orderedDataPoints: [PointData] = {
        dataPoints.sorted { $0.month < $1.month }
    }()

    init(id: UUID,
         dataPoints: [PointData],
         bounties: [Bounty],
         name: String,
         iceCreamPoints: Int,
         negativeIceCreamPoints: Int,
    ) {
        self.id = id
        self.dataPoints = dataPoints
        self.name = name
        self.iceCreamPoints = iceCreamPoints
        self.negativeIceCreamPoints = negativeIceCreamPoints
    }
}

// Functions on a users data for calculating user scores
extension User {

    var hasImproved: Bool {
        guard self.orderedDataPoints.count > 1 else {
            return false
        }

        return self.orderedDataPoints.first?.points ?? 0 < self.orderedDataPoints.last?.points ?? 0
    }

    var max: Int {
        guard self.orderedDataPoints.count > 0 else {
            return 0
        }

        guard self.orderedDataPoints.count > 1 else {
            return orderedDataPoints[0].points
        }

        return self.orderedDataPoints.max { $0.points > $1.points }?.points ?? 0
    }

    var chartYMax: Int {
        guard self.orderedDataPoints.count > 0 else {
            return 0
        }

        guard self.orderedDataPoints.count > 1 else {
            return orderedDataPoints[0].points
        }

        return self.orderedDataPoints.max { $0.points < $1.points }?.points ?? 0
    }

    var chartYMin: Int {
        guard self.orderedDataPoints.count > 0 else {
            return 0
        }

        guard self.orderedDataPoints.count > 1 else {
            return orderedDataPoints[0].points
        }

        return self.orderedDataPoints.min { $0.points < $1.points }?.points ?? 0
    }

    var aggregateSinceLastMonth: Int {

        guard orderedDataPoints.count > 0 else {
            return 0
        }

        guard orderedDataPoints.count > 1 else {
            return orderedDataPoints.first!.points
        }

        return orderedDataPoints.last!.points - orderedDataPoints.dropLast().last!.points
    }
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
        lhs.dataPoints == rhs.dataPoints  &&
        lhs.iceCreamPoints == rhs.iceCreamPoints &&
        lhs.negativeIceCreamPoints == rhs.negativeIceCreamPoints
    }
}
