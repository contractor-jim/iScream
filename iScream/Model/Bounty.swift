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
    var title: String
    var points: Int
    var completed: Bool
    // TODO: Need to resolve how to manage this releationship
    // var user: User

    init(id: UUID,
         title: String,
         points: Int,
         completed: Bool) {
         // user: User) {
        self.id = id
        self.title = title
        self.points = points
        self.completed = completed
        // self.user = user
    }

    enum CodingKeys: String, CodingKey {
        case id, title, points, completed, children, bounties
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        points = try container.decode(Int.self, forKey: .points)
        completed = try container.decode(Bool.self, forKey: .completed)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(points, forKey: .points)
        try container.encode(completed, forKey: .completed)
    }
}
