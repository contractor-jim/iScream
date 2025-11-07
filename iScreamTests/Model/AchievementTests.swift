//
//  AchievementTests.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

@testable import iScream
import Testing
import Foundation

struct AchievementTests {

    let id = UUID()
    let parentId = UUID()
    let parentAuthId = UUID()
    let achievement: Achievement

    init() {
        achievement = Achievement(id: id,
                                  title: "Test",
                                  points: 100,
                                  pendingComplete: false,
                                  complete: true)

    }

    @Test("POSITIVE - Achievement - init") func testInitAchievement() async throws {
        #expect(achievement.id == id)
        #expect(achievement.title == "Test")
        #expect(achievement.points == 100)
        #expect(achievement.pendingComplete == false)
        #expect(achievement.complete == true)
        #expect(achievement == Achievement(id: id,
                                           title: "Test",
                                           points: 100,
                                           pendingComplete: false,
                                           complete: true))
    }

    @Test("POSITIVE - Achievement - coding keys") func testAchievement_CodingKeys() async throws {
        #expect(Achievement.CodingKeys.id.rawValue == "id")
        #expect(Achievement.CodingKeys.title.rawValue == "title")
        #expect(Achievement.CodingKeys.points.rawValue == "points")
        #expect(Achievement.CodingKeys.pendingComplete.rawValue == "pending_complete")
        #expect(Achievement.CodingKeys.complete.rawValue == "complete")
    }
}
