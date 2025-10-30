//
//  Profile.swift
//  iScream
//
//  Created by James Woodbridge on 23/10/2025.
//

import Foundation

// TODO: This needs to be an actual model item in the DB
struct Profile: Codable {
    var id: UUID?
    let userName: String
    // TODO: Need to use user type here
    let type: String
    let points: Int
    let negativePoints: Int
    let parentId: UUID?
    let authId: UUID
    let children: [Profile]?
    var bounties: [Bounty]?

    enum CodingKeys: String, CodingKey {
        case id, type, points, negativePoints, children, bounties
        case userName = "user_name"
        case parentId = "parent_id"
        case authId = "auth_id"
    }

    init(id: UUID? = nil,
         userName: String,
         type: String,
         points: Int,
         negativePoints: Int,
         parentId: UUID? = nil,
         authId: UUID,
         children: [Profile]? = nil,
         bounties: [Bounty]? = nil) {
        self.id = id
        self.userName = userName
        self.type = type
        self.points = points
        self.negativePoints = negativePoints
        self.parentId = parentId
        self.authId = authId
        self.children = children
        self.bounties = bounties
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        userName = try container.decode(String.self, forKey: .userName)
        type = try container.decode(String.self, forKey: .type)
        points = try container.decode(Int.self, forKey: .points)
        negativePoints = try container.decode(Int.self, forKey: .negativePoints)
        parentId = try container.decode(UUID.self, forKey: .parentId)
        authId = try container.decode(UUID.self, forKey: .authId)
        children = try container.decode([Profile].self, forKey: .children)
        bounties = try container.decode([Bounty].self, forKey: .bounties)
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
