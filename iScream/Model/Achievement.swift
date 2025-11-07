//
//  Achievement.swift
//  iScream
//
//  Created by James Woodbridge on 06/11/2025.
//

import Foundation
import SwiftData

@Model
final class Achievement: Codable {
    @Attribute(.unique) var id: UUID
    var title: String
    var points: Int
    var pendingComplete: Bool
    var complete: Bool

    init(id: UUID,
         title: String,
         points: Int,
         pendingComplete: Bool,
         complete: Bool) {
        self.id = id
        self.title = title
        self.points = points
        self.pendingComplete = pendingComplete
        self.complete = complete
    }

    enum CodingKeys: String, CodingKey {
        case id, title, points, complete
        case pendingComplete = "pending_complete"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        points = try container.decode(Int.self, forKey: .points)
        pendingComplete = try container.decode(Bool.self, forKey: .pendingComplete)
        complete = try container.decode(Bool.self, forKey: .complete)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(points, forKey: .points)
        try container.encode(complete, forKey: .complete)
        try container.encode(pendingComplete, forKey: .pendingComplete)
    }
}

extension Achievement: Equatable {
    static func == (lhs: Achievement, rhs: Achievement) -> Bool {
        rhs.id == rhs.id &&
        rhs.title == rhs.title &&
        rhs.points == rhs.points &&
        rhs.complete == rhs.complete &&
        rhs.pendingComplete == rhs.pendingComplete
    }
}
