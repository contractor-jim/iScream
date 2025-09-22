//
//  User.swift
//  iScream
//
//  Created by James Woodbridge on 16/09/2025.
//

import Foundation
import SwiftData

enum UserType: String, CaseIterable, Codable {
    case unknown
    case parent
    case child
}

@Model
final class User {

    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade, inverse: \PointData.user) var dataPoints: [PointData]
    var name: String
    var iceCreamPoints: Int
    var negativeIceCreamPoints: Int
    var type: String
    @Relationship(deleteRule: .cascade) var children: [User]?
    @Relationship(deleteRule: .cascade, inverse: \Bounty.user) var bounties: [Bounty]

    @Transient lazy var orderedDataPoints: [PointData] = {
        dataPoints.sorted { $0.month < $1.month }
    }()

    init(id: UUID,
         dataPoints: [PointData],
         bounties: [Bounty],
         name: String,
         iceCreamPoints: Int,
         negativeIceCreamPoints: Int,
         type: String,
         children: [User] = []) {
        self.id = id
        self.dataPoints = dataPoints
        self.bounties = bounties
        self.name = name
        self.iceCreamPoints = iceCreamPoints
        self.negativeIceCreamPoints = negativeIceCreamPoints
        self.type =  type
        self.children = children
    }
}

// Functions on a users data for calculating user scores
extension User {

    var openBounties: [Bounty] {
        bounties.filter { $0.completed == false }
    }

    var completedBounties: [Bounty] {
        bounties.filter { $0.completed == true }
    }

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
    // TODO: Test this
    var chartYMax: Int {
        guard self.orderedDataPoints.count > 0 else {
            return 0
        }

        guard self.orderedDataPoints.count > 1 else {
            return orderedDataPoints[0].points
        }

        return self.orderedDataPoints.max { $0.points < $1.points }?.points ?? 0
    }
    // TODO: Test this
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
        lhs.negativeIceCreamPoints == rhs.negativeIceCreamPoints &&
        lhs.type == rhs.type &&
        lhs.children == rhs.children &&
        lhs.bounties == rhs.bounties
    }
}
