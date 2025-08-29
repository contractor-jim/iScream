//
//  UserModel.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import Foundation

// TODO: This model will need to be moved to a better location. SwiftDataModel?
struct IceCreamData: Identifiable, Hashable {
    let id = UUID()
    let month: String
    let points: Int
}

struct Bounty: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let points: Int
    let completed: Bool
}

enum UserType {
    case unknown
    case parent
    case child
}

struct User: Hashable, Identifiable {
    let id = UUID()
    let dataPoints: [IceCreamData]
    let name: String
    let iceCreamPoints: Int
    let type: UserType
    var children: [User]
    var openBounties: [Bounty] = []
    var completedBounties: [Bounty] = []

    init(dataPoints: [IceCreamData],
         openBounties: [Bounty],
         completedBounties: [Bounty],
         name: String,
         iceCreamPoints: Int,
         type: UserType = .unknown,
         children: [User] = []) {
        self.dataPoints = dataPoints
        self.openBounties = openBounties
        self.completedBounties = completedBounties
        self.name = name
        self.iceCreamPoints = iceCreamPoints
        self.type = type
        self.children = children
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
