//
//  Item.swift
//  iScream
//
//  Created by james Woodbridge on 26/08/2025.
//
// TODO: This needs to be removed
import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
