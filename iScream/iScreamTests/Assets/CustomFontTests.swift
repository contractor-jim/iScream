//
//  CustomFontTests.swift
//  iScream
//
//  Created by James Woodbridge on 12/09/2025.
//

@testable import iScream
import Testing
import SwiftUI

struct CustomFontTests {

    @Test("POSITIVE - Assert the font information has not changed") func testFonts() throws {
        #expect(CustomFont.headerFontName == "Avenir Black")
        #expect(CustomFont.regularFontName == "Avenir Medium")
        #expect(CustomFont.fontHeaderLargeSize == 32)
        #expect(CustomFont.fontSubHeaderLargeSize == 20)
        #expect(CustomFont.fontSubHeaderSmallSize == 16)
        #expect(CustomFont.fontExtraSmallSize == 12)
        #expect(CustomFont.fontRegularBodySize == 18)
        #expect(CustomFont.fontSmallBodySize == 10)
        #expect(CustomFont.headerFont == Font.custom(CustomFont.headerFontName, fixedSize: CustomFont.fontHeaderLargeSize))
        #expect(CustomFont.subHeaderFont == Font.custom(CustomFont.headerFontName, fixedSize: CustomFont.fontSubHeaderLargeSize))
        #expect(CustomFont.smallSubHeaderFont == Font.custom(CustomFont.headerFontName, fixedSize: CustomFont.fontSubHeaderSmallSize))
        #expect(CustomFont.regularFontBody == Font.custom(CustomFont.headerFontName, fixedSize: CustomFont.fontRegularBodySize))
        #expect(CustomFont.smallFontBody == Font.custom(CustomFont.headerFontName, fixedSize: CustomFont.fontSmallBodySize))
        #expect(CustomFont.extraSmallFontBody == Font.custom(CustomFont.regularFontName, fixedSize: CustomFont.fontExtraSmallSize))
    }

}
