//
//  Bounty.swift
//  iScream
//
//  Created by James Woodbridge on 16/09/2025.
//

import Foundation
import SwiftData

enum BountyRarity: String, Codable {
    case bronze
    case silver
    case gold
    case platinum
}

@Model
final class Bounty: Codable {
    @Attribute(.unique) var id: UUID
    var parentId: UUID
    var title: String
    var points: Int
    var completed: Bool
    var pendingComplete: Bool
    var rarity: BountyRarity

    init(id: UUID,
         parentId: UUID,
         title: String,
         points: Int,
         completed: Bool,
         pendingComplete: Bool,
         rarity: BountyRarity) {
        self.id = id
        self.parentId = parentId
        self.title = title
        self.points = points
        self.completed = completed
        self.pendingComplete = pendingComplete
        self.rarity = rarity
    }

    enum CodingKeys: String, CodingKey {
        case id, title, points, completed, rarity
        case parentId = "parent_id"
        case pendingComplete = "pending_complete"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        points = try container.decode(Int.self, forKey: .points)
        completed = try container.decode(Bool.self, forKey: .completed)
        parentId = try container.decode(UUID.self, forKey: .parentId)
        pendingComplete = try container.decode(Bool.self, forKey: .pendingComplete)
        rarity = try container.decode(BountyRarity.self, forKey: .rarity)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(points, forKey: .points)
        try container.encode(completed, forKey: .completed)
        try container.encode(parentId, forKey: .parentId)
        try container.encode(pendingComplete, forKey: .pendingComplete)
        try container.encode(rarity, forKey: .rarity)
    }
}

extension Bounty: Equatable {
    static func == (lhs: Bounty, rhs: Bounty) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.points == rhs.points &&
        lhs.completed == rhs.completed &&
        lhs.parentId == rhs.parentId &&
        lhs.pendingComplete == rhs.pendingComplete &&
        lhs.rarity == rhs.rarity
    }
}
