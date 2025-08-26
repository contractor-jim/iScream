//
//  ParentListChildrenEntity.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import Foundation
import SwiftData

// TODO: This model will need to be moved to a better location. SwiftDataModel?
struct IceCreamData: Identifiable, Hashable {
    let id = UUID()
    let month: String
    let points: Int
}

struct User: Hashable, Identifiable {
    let id = UUID()
    let dataPoints: [IceCreamData]
    let name: String
    let iceCreamPoints: Int

    init(dataPoints: [IceCreamData], name: String, iceCreamPoints: Int) {
        self.dataPoints = dataPoints
        self.name = name
        self.iceCreamPoints = iceCreamPoints
    }

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var hasImproved: Bool {
        get {
            guard self.dataPoints.count > 1 else {
                return false
            }

            return self.dataPoints.first?.points ?? 0 > self.dataPoints.last?.points ?? 0
        }
    }

    var max: Int {
        get {
            guard self.dataPoints.count > 1 else {
                return 0
            }

            return self.dataPoints.max{ $0.points > $1.points }?.points ?? 0
        }
    }

    var aggregateSinceLastMonth: Int {
        get {
            guard dataPoints.count > 0 else {
                return 0
            }

            guard dataPoints.count > 1 else {
                return dataPoints.first!.points
            }

            return dataPoints.last!.points - dataPoints.dropLast().last!.points
        }
    }
}

protocol ParentListChildrenEntity {

}

final class ParentListChildrenEntityImp: ParentListChildrenEntity {

}
