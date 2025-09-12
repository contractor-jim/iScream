//
//  StyleTests.swift
//  iScream
//
//  Created by James Woodbridge on 12/09/2025.
//

@testable import iScream
import Testing

struct StyleTests {

    @Test("POSITIVE - Corner radius should meet design requirements") func testRadius() throws {
        #expect(Style.cornerRadius == 16)
    }

    @Test("POSITIVE - Margins should meet design requirements") func testMargins() throws {
        #expect(Style.topPadding == 26)
        #expect(Style.fullPadding == 16)
        #expect(Style.halfPadding == 8)
    }
}
