//
//  Date+SupabaseStringTests.swift
//  iScream
//
//  Created by James Woodbridge on 10/11/2025.
//

@testable import iScream
import Testing
import Foundation

struct DateSupabaseStringTests {
    @Test("POSITIVE - DateSupabaseStringTests - Date from String") func testDateFromSupabaseString() async throws {
        let dateString = "2025-01-01T10:24:19+00:00"
        let date = Date.dateFromSupabaseString(dateString: dateString)
        #expect(date != nil)
    }

    @Test("POSITIVE - DateSupabaseStringTests - String from Date") func testSupabaseStringFromDate() async throws {
        let dateString = "2025-01-01T10:24:19+0000"
        let date = Date.dateFromSupabaseString(dateString: dateString)
        #expect(date?.supabaseStringFromDate() == dateString)
    }
}
