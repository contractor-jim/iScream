//
//  Bounty.swift
//  iScream
//
//  Created by James Woodbridge on 16/09/2025.
//

import Foundation
import SwiftData

@Model
final class Bounty: Codable {
    @Attribute(.unique) var id: UUID
    @Relationship(inverse: \Profile.id)
    var parentId: UUID
    var title: String
    var points: Int
    var completed: Bool
    @Relationship(inverse: \Profile.bounties)
    var profile: [Profile]?

    init(id: UUID,
         parentId: UUID,
         title: String,
         points: Int,
         completed: Bool,
         profile: [Profile]?) {
        self.id = id
        self.parentId = parentId
        self.title = title
        self.points = points
        self.completed = completed
        self.profile = profile
    }

    enum CodingKeys: String, CodingKey {
        case id, title, points, completed, children, bounties, profile
        case parentId = "parent_id"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        points = try container.decode(Int.self, forKey: .points)
        completed = try container.decode(Bool.self, forKey: .completed)
        profile = try container.decodeIfPresent([Profile].self, forKey: .profile)
        parentId = try container.decode(UUID.self, forKey: .parentId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(points, forKey: .points)
        try container.encode(completed, forKey: .completed)
        try container.encode(profile, forKey: .profile)
        try container.encode(parentId, forKey: .parentId)
    }
}
