//
//  UserService.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import Foundation
import SwiftData
import SwiftUI

protocol UserService: Equatable {
    func getUser() async throws -> User?
}

class DefaultUserService: GenericService, UserService {

    static var modelContext: ModelContext?
    static var didLoad = false
    // TODO: test this
    override init() {

        if !DefaultUserService.didLoad {
            // Mocked data for now till we get the database in place
            guard let modelContext = DefaultUserService.modelContext else {
                fatalError("Model context not set on the UserService")
            }

            do {
                try modelContext.delete(model: PointData.self)
                try modelContext.delete(model: User.self)
                try modelContext.delete(model: Bounty.self)
            } catch {
                fatalError("Failed to clear the cache \(error)")
            }
            // Jacks mocked data
            modelContext.insert(PointData(id: UUID(), month: "Jan", points: 5))
            modelContext.insert(PointData(id: UUID(), month: "Feb", points: 11))
            modelContext.insert(PointData(id: UUID(), month: "Mar", points: -2))
            modelContext.insert(PointData(id: UUID(), month: "Apr", points: 2))
            modelContext.insert(PointData(id: UUID(), month: "May", points: 9))
            modelContext.insert(PointData(id: UUID(), month: "Jun", points: -5))
            modelContext.insert(PointData(id: UUID(), month: "Jul", points: 10))

            modelContext.insert(Bounty(id: UUID(), title: "Clean your room", points: 10, completed: false))
            modelContext.insert(Bounty(id: UUID(), title: "Mow the lawn", points: 20, completed: false))
            modelContext.insert(Bounty(id: UUID(), title: "Take out the bins", points: 2, completed: false))
            modelContext.insert(Bounty(id: UUID(), title: "Do your math homework", points: 5, completed: false))

            modelContext.insert(Bounty(id: UUID(), title: "Do Geography Homework", points: 5, completed: true))
            modelContext.insert(Bounty(id: UUID(), title: "Tidy up your toys", points: 2, completed: true))
            modelContext.insert(Bounty(id: UUID(), title: "Be a good boy for Nanny", points: 10, completed: true))
            modelContext.insert(Bounty(id: UUID(), title: "Eat all your dinner", points: 2, completed: true))

            let pointDataFetchDescriptor = FetchDescriptor<PointData>()
            let incompleteBountyFetchDescriptor = FetchDescriptor<Bounty>(predicate: #Predicate { bounty in
                bounty.completed == false
            })
            let completeBountyFetchDescriptor = FetchDescriptor<Bounty>(predicate: #Predicate { bounty in
                bounty.completed == true
            })

            do {
                let dataPoints = try modelContext.fetch(pointDataFetchDescriptor)
                let incompleteBounties = try modelContext.fetch(incompleteBountyFetchDescriptor)
                let completeBounties = try modelContext.fetch(completeBountyFetchDescriptor)

                for dataPoint in dataPoints {
                    print(">>> dataPoint \(dataPoint.month)")
                }

                for bounty in incompleteBounties {
                    print(">>> incompleteBounty \(bounty.title)")
                }

                for bounty in completeBounties {
                    print(">>> dataPoint \(bounty.title)")
                }

                // Insert Jack
                modelContext.insert(User(id: UUID(),
                                         dataPoints: dataPoints,
                                         openBounties: incompleteBounties,
                                         completedBounties: completeBounties,
                                         name: "Jack",
                                         iceCreamPoints: 1000,
                                         negativeIceCreamPoints: 20,
                                         type: "child"))
                // Insert Jem
                modelContext.insert(User(id: UUID(),
                                         dataPoints: dataPoints,
                                         openBounties: incompleteBounties,
                                         completedBounties: completeBounties,
                                         name: "Mummy",
                                         iceCreamPoints: 450,
                                         negativeIceCreamPoints: 20,
                                         type: "child"))

                // Insert Chris
                modelContext.insert(User(id: UUID(),
                                         dataPoints: dataPoints,
                                         openBounties: incompleteBounties,
                                         completedBounties: completeBounties,
                                         name: "Chris",
                                         iceCreamPoints: -10000000,
                                         negativeIceCreamPoints: -10000000,
                                         type: "child"))

            } catch {
                print("Failed to create mock user model. \(error)")
            }

            DefaultUserService.didLoad = true
            /*
             let mummyIceCreamDataPoints = [
             IceCreamData(month: "Jan", points: 11),
             IceCreamData(month: "Feb", points: 9),
             IceCreamData(month: "Mar", points: 4),
             IceCreamData(month: "Apr", points: 10),
             IceCreamData(month: "May", points: 23),
             IceCreamData(month: "Jun", points: 35),
             IceCreamData(month: "Jul", points: 50)
             ]

             let chrisIceCreamDataPoints = [
             IceCreamData(month: "Jan", points: 0),
             IceCreamData(month: "Feb", points: -10),
             IceCreamData(month: "Mar", points: -99),
             IceCreamData(month: "Apr", points: -1000),
             IceCreamData(month: "May", points: -3000),
             IceCreamData(month: "Jun", points: -3500),
             IceCreamData(month: "Jul", points: -50000)
             ]

             // TODO: This is incorrect as we shouldn't be adding testing code in the app. Add some switching for mock json when the network is built
             let parentTesting = ProcessInfo.processInfo.arguments.contains("USER_PARENT")
             let childTesting = ProcessInfo.processInfo.arguments.contains("USER_CHILD")

             var userType: UserType = .parent
             userType = parentTesting ? .parent : userType
             userType = childTesting ? .child : userType

             mockUser = User(dataPoints: jackIceCreamDataPoints,
             openBounties: openBountyData,
             completedBounties: completedBountyData,
             name: "Daddy",
             iceCreamPoints: 1000,
             negativeIceCreamPoints: 200,
             type: userType)

             */
        }
    }
    // TODO: test this
    func getUser() async throws -> User? {
        guard let modelContext = DefaultUserService.modelContext else {
            return nil
        }

        let userFetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
            user.type == "child"
        })
        // TODO: This needs to be an actual search on the user post login
        return try modelContext.fetch(userFetchDescriptor).first
    }
}

extension DefaultUserService: Equatable {
    static func == (lhs: DefaultUserService, rhs: DefaultUserService) -> Bool {
        // TODO: Need to equate this or do we ?
        true
        // rhs.mockUser == rhs.mockUser
    }
}
