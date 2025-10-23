//
//  UserService.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import Foundation
import SwiftData

protocol UserService {
    func getUser() async throws -> User?
    func registerUser(email: String, password: String, nickname: String) async throws -> UUID
    func loginUser(email: String, password: String) async throws -> UUID

    func insertProfile(profile: Profile) async throws
    func fetchProfile(userId: UUID) async throws -> Profile?
}

class DefaultUserService: GenericService, UserService {

    static var modelContext: ModelContext?
    static var didLoad = false
    let supabaseService: SupaBaseService

    init(supabaseService: SupaBaseService) {

        self.supabaseService = supabaseService

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

    func getUser() async throws -> User? {
        guard let modelContext = DefaultUserService.modelContext else {
            return nil
        }

        // TODO: This is incorrect as we shouldn't be adding testing code in the app. Add some switching for mock json when the network is built
        var type = "parent"
        var userName = "Daddy"

        let parentTesting = ProcessInfo.processInfo.arguments.contains("USER_PARENT")
        if parentTesting {
            type = "parent"
            userName = "Daddy"
        }

        let childTesting = ProcessInfo.processInfo.arguments.contains("USER_CHILD")
        if childTesting {
            type = "child"
            userName = "Jack"
        }
        let userFetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
            user.type == type && user.name == userName
        })
        // TODO: This needs to be an actual search on the user post login
        return try modelContext.fetch(userFetchDescriptor).first
    }

    /*
     WE ARE CALLING ACTUALL FUNCTIONS FROM HERE
     */
    func registerUser(email: String, password: String, nickname: String) async throws -> UUID {
        let response = try await supabaseService.client?.auth.signUp(
          email: email,
          password: password,
          data: ["display_name": .string(nickname)]
        )

        // TODO: Test that a UUID exists and the response was succesfull
        return response!.user.id
    }

    func loginUser(email: String, password: String) async throws -> UUID {
        let response = try await supabaseService.client?.auth.signIn(
            email: email,
            password: password
        )

        // TODO: Test that a UUID exists and the response was succesfull
        return response!.user.id
    }

    func insertProfile(profile: Profile) async throws {
        try await supabaseService.insert(table: "user_profile", object: profile)
    }

    func fetchProfile(userId: UUID) async throws -> Profile? {
        return try await supabaseService.fetch(table: "user_profile", eq: ["authId": userId], type: Profile.self)
    }
}

extension DefaultUserService {

    fileprivate func createMockUsers(modelContext: ModelContext) {
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
                   graphData: [("2025-01-01T00:00:00Z", 11),
                               ("2025-02-01T00:00:00Z", 9),
                               ("2025-03-01T00:00:00Z", 10),
                               ("2025-04-01T00:00:00Z", 23),
                               ("2025-05-01T00:00:00Z", 35),
                               ("2025-06-01T00:00:00Z", 40),
                               ("2025-07-01T00:00:00Z", 55)])

        createUser(modelContext: modelContext,
                   id: jemsUUID,
                   user: User(id: jemsUUID,
                              dataPoints: [],
                              bounties: [],
                              name: "Mummy",
                              iceCreamPoints: 450,
                              negativeIceCreamPoints: 20,
                              type: "child"),
                   graphData: [("2025-01-01T00:00:00Z", 11),
                               ("2025-02-01T00:00:00Z", 9),
                               ("2025-03-01T00:00:00Z", 10),
                               ("2025-04-01T00:00:00Z", 23),
                               ("2025-05-01T00:00:00Z", 35),
                               ("2025-06-01T00:00:00Z", 50),
                               ("2025-07-01T00:00:00Z", 55)])

        createUser(modelContext: modelContext,
                   id: chrisUUID,
                   user: User(id: chrisUUID,
                              dataPoints: [],
                              bounties: [],
                              name: "Chris",
                              iceCreamPoints: -10000000,
                              negativeIceCreamPoints: -10000000,
                              type: "child"),
                   graphData: [("2025-01-01T00:00:00Z", 0),
                               ("2025-02-01T00:00:00Z", -10),
                               ("2025-03-01T00:00:00Z", -99),
                               ("2025-04-01T00:00:00Z", -1000),
                               ("2025-05-01T00:00:00Z", -3000),
                               ("2025-06-01T00:00:00Z", -3500),
                               ("2025-07-01T00:00:00Z", -5000)])

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
            print("Failed ot create parent \(error)")
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
                let formatter = ISO8601DateFormatter()
                modelContext.insert(PointData(id: UUID(), month: formatter.date(from: data.0)!, points: data.1, user: user))
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
            print("Failed to create the user \(error)")
        }
    }
}
