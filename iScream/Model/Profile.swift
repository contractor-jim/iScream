//
//  Profile.swift
//  iScream
//
//  Created by James Woodbridge on 23/10/2025.
//

import Foundation

// TODO: This needs to be an actual model item in the DB
struct Profile: Codable {
    var id: UUID? = nil
    let userName: String
    let type: String
    let points: Int
    let negativePoints: Int
    let parentId: UUID?
    let authId: UUID
}
