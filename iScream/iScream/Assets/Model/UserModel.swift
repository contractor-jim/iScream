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
// TODO: This is not correct as ID should also be used as Unique but this would come from the Server
extension IceCreamData: Equatable {
    static func == (lhs: IceCreamData, rhs: IceCreamData) -> Bool {
        rhs.month == rhs.month &&
        rhs.points == rhs.points
    }
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

struct User: Identifiable {
    let id = UUID()
    let dataPoints: [IceCreamData]
    let name: String
    let iceCreamPoints: Int
    let negativeIceCreamPoints: Int
    let type: UserType
    var children: [User]
    var openBounties: [Bounty] = []
    var completedBounties: [Bounty] = []

    init(dataPoints: [IceCreamData],
         openBounties: [Bounty],
         completedBounties: [Bounty],
         name: String,
         iceCreamPoints: Int,
         negativeIceCreamPoints: Int,
         type: UserType = .unknown,
         children: [User] = []) {
        self.dataPoints = dataPoints
        self.openBounties = openBounties
        self.completedBounties = completedBounties
        self.name = name
        self.iceCreamPoints = iceCreamPoints
        self.negativeIceCreamPoints = negativeIceCreamPoints
        self.type =  type
        self.children = children
    }

    var hasImproved: Bool {
        guard self.dataPoints.count > 1 else {
            return false
        }

        return self.dataPoints.first?.points ?? 0 > self.dataPoints.last?.points ?? 0
    }

    var max: Int {
        guard self.dataPoints.count > 1 else {
            return 0
        }

        return self.dataPoints.max { $0.points > $1.points }?.points ?? 0
    }

    var aggregateSinceLastMonth: Int {
        guard dataPoints.count > 0 else {
            return 0
        }

        guard dataPoints.count > 1 else {
            return dataPoints.first!.points
        }

        return dataPoints.last!.points - dataPoints.dropLast().last!.points
    }
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
        lhs.dataPoints == rhs.dataPoints  &&
        lhs.iceCreamPoints == rhs.iceCreamPoints &&
        lhs.negativeIceCreamPoints == rhs.negativeIceCreamPoints &&
        lhs.type == rhs.type &&
        lhs.children == rhs.children &&
        lhs.openBounties == rhs.openBounties &&
        lhs.completedBounties == rhs.completedBounties
    }
}
