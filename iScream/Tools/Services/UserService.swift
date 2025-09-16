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

        super.init()
        if !DefaultUserService.didLoad {
            // Mocked data for now till we get the database in place
            guard let modelContext = DefaultUserService.modelContext else {
                fatalError("Model context not set on the UserService")
            }

            do {
                try modelContext.delete(model: User.self)
            } catch {
                fatalError("Failed to clear the cache \(error)")
            }

            let jacksUUID = UUID()
            let jemsUUID = UUID()
            let chrisUUID = UUID()

            createJack(modelContext: modelContext, id: jacksUUID)
            createJem(modelContext: modelContext, id: jemsUUID)
            createChris(modelContext: modelContext, id: chrisUUID)

            DefaultUserService.didLoad = true
            /*

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

extension DefaultUserService {
    func createJack(modelContext: ModelContext, id: UUID) {
        modelContext.insert(User(id: id,
                                 dataPoints: [],
                                 bounties: [],
                                 name: "Jack",
                                 iceCreamPoints: 1000,
                                 negativeIceCreamPoints: 20,
                                 type: "child"))

        let jackFetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
            user.id == id
        })

        do {
            let jack = try modelContext.fetch(jackFetchDescriptor).first!

            // Jacks mocked data
            modelContext.insert(PointData(id: UUID(), month: "Jan", points: 5, user: jack))
            modelContext.insert(PointData(id: UUID(), month: "Feb", points: 11, user: jack))
            modelContext.insert(PointData(id: UUID(), month: "Mar", points: -2, user: jack))
            modelContext.insert(PointData(id: UUID(), month: "Apr", points: 2, user: jack))
            modelContext.insert(PointData(id: UUID(), month: "May", points: 9, user: jack))
            modelContext.insert(PointData(id: UUID(), month: "Jun", points: -5, user: jack))
            modelContext.insert(PointData(id: UUID(), month: "Jul", points: 10, user: jack))

            modelContext.insert(Bounty(id: UUID(), title: "Clean your room", points: 10, completed: false, user: jack))
            modelContext.insert(Bounty(id: UUID(), title: "Mow the lawn", points: 20, completed: false, user: jack))
            modelContext.insert(Bounty(id: UUID(), title: "Take out the bins", points: 2, completed: false, user: jack))
            modelContext.insert(Bounty(id: UUID(), title: "Do your math homework", points: 5, completed: false, user: jack))

            modelContext.insert(Bounty(id: UUID(), title: "Do Geography Homework", points: 5, completed: true, user: jack))
            modelContext.insert(Bounty(id: UUID(), title: "Tidy up your toys", points: 2, completed: true, user: jack))
            modelContext.insert(Bounty(id: UUID(), title: "Be a good boy for Nanny", points: 10, completed: true, user: jack))
            modelContext.insert(Bounty(id: UUID(), title: "Eat all your dinner", points: 2, completed: true, user: jack))
        } catch {
            print(">>> FAILED TO CREATE JACK")
        }
    }

    func createJem(modelContext: ModelContext, id: UUID) {
        modelContext.insert(User(id: id,
                                 dataPoints: [],
                                 bounties: [],
                                 name: "Mummy",
                                 iceCreamPoints: 450,
                                 negativeIceCreamPoints: 20,
                                 type: "child"))

        let userFetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
            user.id == id
        })

        do {
            let user = try modelContext.fetch(userFetchDescriptor).first!

            modelContext.insert(PointData(id: UUID(), month: "Jan", points: 11, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Feb", points: 9, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Mar", points: 10, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Apr", points: 23, user: user))
            modelContext.insert(PointData(id: UUID(), month: "May", points: 35, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Jun", points: 50, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Jul", points: 55, user: user))

            modelContext.insert(Bounty(id: UUID(), title: "Clean your room", points: 10, completed: false, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Mow the lawn", points: 20, completed: false, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Take out the bins", points: 2, completed: false, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Do your math homework", points: 5, completed: false, user: user))

            modelContext.insert(Bounty(id: UUID(), title: "Do Geography Homework", points: 5, completed: true, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Tidy up your toys", points: 2, completed: true, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Be a good boy for Nanny", points: 10, completed: true, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Eat all your dinner", points: 2, completed: true, user: user))
        } catch {
            print(">>> FAILED TO CREATE USER")
        }
    }

    func createChris(modelContext: ModelContext, id: UUID) {
        
        modelContext.insert(User(id: id,
                                 dataPoints: [],
                                 bounties: [],
                                 name: "Chris",
                                 iceCreamPoints: -10000000,
                                 negativeIceCreamPoints: -10000000,
                                 type: "child"))

        let userFetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
            user.id == id
        })

        do {
            let user = try modelContext.fetch(userFetchDescriptor).first!

            modelContext.insert(PointData(id: UUID(), month: "Jan", points: 0, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Feb", points: -10, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Mar", points: -99, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Apr", points: -1000, user: user))
            modelContext.insert(PointData(id: UUID(), month: "May", points: -3000, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Jun", points: -3500, user: user))
            modelContext.insert(PointData(id: UUID(), month: "Jul", points: -5000, user: user))

            modelContext.insert(Bounty(id: UUID(), title: "Clean your room", points: 10, completed: false, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Mow the lawn", points: 20, completed: false, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Take out the bins", points: 2, completed: false, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Do your math homework", points: 5, completed: false, user: user))

            modelContext.insert(Bounty(id: UUID(), title: "Do Geography Homework", points: 5, completed: true, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Tidy up your toys", points: 2, completed: true, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Be a good boy for Nanny", points: 10, completed: true, user: user))
            modelContext.insert(Bounty(id: UUID(), title: "Eat all your dinner", points: 2, completed: true, user: user))
        } catch {
            print(">>> FAILED TO CREATE USER")
        }
    }
}
