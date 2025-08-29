//
//  CustomFont.swift
//  IceCream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

// TODO: Write tests for these

struct CustomFont {
    // Font names
    static let headerFontName = "Avenir Black"
    static let regularFontName = "Avenir Medium"

    // Sizes
    static let fontHeaderLargeSize: CGFloat = 32
    static let fontSubHeaderLargeSize: CGFloat = 20
    static let fontSubHeaderSmallSize: CGFloat = 16

    static let fontRegularBodySize: CGFloat = 18
    static let fontSmallBodySize: CGFloat = 10
    // Headings
    static let headerFont: Font = .custom(headerFontName, fixedSize: fontHeaderLargeSize)
    static let subHeaderFont: Font = .custom(headerFontName, fixedSize: fontSubHeaderLargeSize)
    static let smallSubHeaderFont: Font = .custom(headerFontName, fixedSize: fontSubHeaderSmallSize)

    // Body content
    static let regularFontBody: Font = .custom(headerFontName, fixedSize: fontRegularBodySize)
    static let smallFontBody: Font = .custom(headerFontName, fixedSize: fontSmallBodySize)
}
