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

            createMockUsers(modelContext: modelContext)

            DefaultUserService.didLoad = true
        }
    }
    // TODO: test this
    func getUser() async throws -> User? {
        guard let modelContext = DefaultUserService.modelContext else {
            return nil
        }

        // TODO: This is incorrect as we shouldn't be adding testing code in the app. Add some switching for mock json when the network is built
        /// let parentTesting = ProcessInfo.processInfo.arguments.contains("USER_PARENT")
        // let childTesting = ProcessInfo.processInfo.arguments.contains("USER_CHILD")

        // var userType: UserType = .parent
        // userType = parentTesting ? .parent : userType
        // userType = childTesting ? .child : userType

        let userFetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
            user.type == "parent"
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
    func createMockUsers(modelContext: ModelContext) {
        let jacksUUID = UUID()
        let jemsUUID = UUID()
        let chrisUUID = UUID()

        createUser(modelContext: modelContext,
                   id: jacksUUID,
                   user: User(id: jacksUUID,
                              dataPoints: [],
                              bounties: [],
                              name: "Jack",
                              iceCreamPoints: 1000,
                              negativeIceCreamPoints: 20,
                              type: "child"),
                   graphData: [("Jan", 11),
                               ("Feb", 9),
                               ("Mar", 10),
                               ("Apr", 23),
                               ("May", 35),
                               ("Jun", 50),
                               ("Jul", 55)])

        createUser(modelContext: modelContext,
                   id: jemsUUID,
                   user: User(id: jemsUUID,
                              dataPoints: [],
                              bounties: [],
                              name: "Mummy",
                              iceCreamPoints: 450,
                              negativeIceCreamPoints: 20,
                              type: "child"),
                   graphData: [("Jan", 11),
                               ("Feb", 9),
                               ("Mar", 10),
                               ("Apr", 23),
                               ("May", 35),
                               ("Jun", 50),
                               ("Jul", 55)])

        createUser(modelContext: modelContext,
                   id: chrisUUID,
                   user: User(id: chrisUUID,
                              dataPoints: [],
                              bounties: [],
                              name: "Chris",
                              iceCreamPoints: -10000000,
                              negativeIceCreamPoints: -10000000,
                              type: "child"),
                   graphData: [("Jan", 0),
                               ("Feb", -10),
                               ("Mar", -99),
                               ("Apr", -1000),
                               ("May", -3000),
                               ("Jun", -3500),
                               ("Jul", -5000)])

        do {
            let userFetchDescriptor = FetchDescriptor<User>()
            let children = try modelContext.fetch(userFetchDescriptor)

            modelContext.insert(User(id: UUID(),
                                     dataPoints: [],
                                     bounties: [],
                                     name: "Daddy",
                                     iceCreamPoints: 0,
                                     negativeIceCreamPoints: 0,
                                     type: "parent",
                                     children: children))

        } catch {
            print("Failed ot create parent")
        }
    }

    func createUser(modelContext: ModelContext, id: UUID, user: User, graphData: [(String, Int)]) {
        modelContext.insert(user)

        let userFetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
            user.id == id
        })

        do {
            let user = try modelContext.fetch(userFetchDescriptor).first!

            for data in graphData {
                modelContext.insert(PointData(id: UUID(), month: data.0, points: data.1, user: user))
            }

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
