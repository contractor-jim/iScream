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
    let type: String
    let points: Int
    let negativePoints: Int
    let parentId: UUID?
    let authId: UUID
    let children: [Profile]?

    enum CodingKeys: String, CodingKey {
        case id, type, points, negativePoints, children
        case userName = "user_name"
        case parentId = "parent_id"
        case authId = "auth_id"
    }
}
