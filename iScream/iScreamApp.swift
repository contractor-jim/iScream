//
//  iScreamApp.swift
//  iScream
//
//  Created by james Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

@main
// swiftlint:disable:next type_name
struct iScreamApp: App {

    let modelContainer: ModelContainer

    init() {
        let schema = Schema([
            Profile.self,
            PointData.self,
            Bounty.self
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

        DefaultUserService.modelContext = modelContainer.mainContext
    }

     var body: some Scene {
        WindowGroup {
            StartupManager.default.getFirstView()
        }
        .modelContainer(modelContainer)
    }
}
