//
//  CustomButton.swift
//  iScream
//
//  Created by James Woodbridge on 26/09/2025.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.pink)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .font(CustomFont.regularFontBody)
    }
}
