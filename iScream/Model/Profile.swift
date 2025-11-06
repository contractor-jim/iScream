//
//  Profile.swift
//  iScream
//
//  Created by James Woodbridge on 23/10/2025.
//

import Foundation
import SwiftData

enum UserType: String, CaseIterable, Codable {
    case unknown
    case parent
    case child
}

// TODO: Test this
@Model
final class Profile: Codable {
    var id: UUID?
    var userName: String
    var type: UserType
    var points: Int
    var negativePoints: Int
    var parentId: UUID?
    var authId: UUID
    var children: [Profile]?
    var managedBounties: [Bounty]?
    var bounties: [Bounty]?
    var dataPoints: [PointData]?
    var achievements: [Achievement]?

    enum CodingKeys: String, CodingKey {
        case id, type, points, negativePoints, children, bounties, achievements
        case userName = "user_name"
        case parentId = "parent_id"
        case authId = "auth_id"
        case managedBounties = "managed_bounties"
        case dataPoints = "data_points"
    }

    init(id: UUID? = nil,
         userName: String,
         type: UserType,
         points: Int,
         negativePoints: Int,
         parentId: UUID?,
         authId: UUID,
         children: [Profile]?,
         managedBounties: [Bounty]?,
         bounties: [Bounty]?,
         dataPoints: [PointData]?,
         achievements: [Achievement]?) {
        self.id = id
        self.userName = userName
        self.type = type
        self.points = points
        self.negativePoints = negativePoints
        self.parentId = parentId
        self.authId = authId
        self.children = children
        self.managedBounties = managedBounties
        self.bounties = bounties
        self.dataPoints = dataPoints
        self.achievements = achievements
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        userName = try container.decode(String.self, forKey: .userName)
        type = try container.decode(UserType.self, forKey: .type)
        points = try container.decode(Int.self, forKey: .points)
        negativePoints = try container.decode(Int.self, forKey: .negativePoints)
        parentId = try container.decodeIfPresent(UUID.self, forKey: .parentId)
        authId = try container.decode(UUID.self, forKey: .authId)
        children = try container.decodeIfPresent([Profile].self, forKey: .children)
        managedBounties = try container.decodeIfPresent([Bounty].self, forKey: .managedBounties)
        bounties = try container.decodeIfPresent([Bounty].self, forKey: .managedBounties)
        achievements = try container.decodeIfPresent([Achievement].self, forKey: .achievements)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userName, forKey: .userName)
        try container.encode(type, forKey: .type)
        try container.encode(points, forKey: .points)
        try container.encode(negativePoints, forKey: .negativePoints)
        try container.encode(parentId, forKey: .parentId)
        try container.encode(authId, forKey: .authId)
    }

    @Transient lazy var orderedDataPoints: [PointData] = {
        dataPoints?.sorted { $0.month < $1.month } ?? []
    }()
}

extension Profile {

    var openBounties: [Bounty] {
        bounties?.filter { $0.completed == false } ?? []
    }

    var completedBounties: [Bounty] {
        bounties?.filter { $0.completed == true } ?? []
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

    var lastMonthString: String {
        guard dataPoints?.count ?? 0 > 1 else {
            return ""
        }

        if dataPoints?.count ?? 0 == 1 {
            return dataPoints?.last!.monthString ?? "Error"
        }

        return dataPoints?.dropLast().last!.monthString ?? "Error"
    }
}

extension Profile: Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.id == rhs.id &&
        lhs.userName == rhs.userName  &&
        lhs.type == rhs.type &&
        lhs.points == rhs.points &&
        lhs.negativePoints == rhs.negativePoints &&
        lhs.parentId == rhs.parentId &&
        lhs.authId == rhs.authId &&
        lhs.children == rhs.children &&
        lhs.bounties == rhs.bounties &&
        lhs.dataPoints == rhs.dataPoints &&
        lhs.achievements == rhs.achievements
    }
}

extension Profile: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
