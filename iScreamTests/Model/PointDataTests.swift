//
//  PointDataTests.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

@testable import iScream
import Testing
import Foundation

struct PointDataTests {

    let id = UUID()
    let date = Date()
    let pointData: PointData

    init() {
        pointData = PointData(id: id,
                              month: date,
                              points: 100)
    }

    @Test("POSITIVE - user profile parent init") func testInitParentUserProfile() async throws {
        #expect(pointData.id == id)
        #expect(pointData.month == date)
        #expect(pointData.points == 100)
        #expect(pointData == PointData(id: id,
                                       month: date,
                                       points: 100))
    }

    @Test("POSITIVE - user profile coding keys") func testProfile_CodingKeys() async throws {
        #expect(PointData.CodingKeys.id.rawValue == "id")
        #expect(PointData.CodingKeys.month.rawValue == "entry_date")
        #expect(PointData.CodingKeys.points.rawValue == "points")
    }
}
