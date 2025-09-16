//
//  Bounty.swift
//  iScream
//
//  Created by James Woodbridge on 16/09/2025.
//

import Foundation
import SwiftData

@Model
final class Bounty {
    @Attribute(.unique) var id: UUID
    var title: String
    var points: Int
    var completed: Bool
    var user: User

    init(id: UUID,
         title: String,
         points: Int,
         completed: Bool,
         user: User) {
        self.id = id
        self.title = title
        self.points = points
        self.completed = completed
        self.user = user
    }
}
