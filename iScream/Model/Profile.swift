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

    enum CodingKeys: String, CodingKey {
        case id, type, points, negativePoints, children, bounties
        case userName = "user_name"
        case parentId = "parent_id"
        case authId = "auth_id"
        case managedBounties = "managed_bounties"
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
         bounties: [Bounty]?) {
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
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userName, forKey: .userName)
        try container.encode(type, forKey: .type)
        try container.encode(points, forKey: .points)
        try container.encode(negativePoints, forKey: .negativePoints)
        try container.encode(parentId, forKey: .parentId)
        try container.encode(authId, forKey: .authId)
        try container.encode(children, forKey: .children)
        try container.encode(managedBounties, forKey: .managedBounties)
        try container.encode(bounties, forKey: .bounties)
    }
}

extension Profile {

    var openBounties: [Bounty] {
        bounties?.filter { $0.completed == false } ?? []
    }

    var completedBounties: [Bounty] {
        bounties?.filter { $0.completed == true } ?? []
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
        lhs.bounties == rhs.bounties
    }
}
