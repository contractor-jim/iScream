//
//  AnimatedNumberTextView.swift
//  iScream
//
//  Created by James Woodbridge on 23/09/2025.
//

import SwiftUI

struct AnimatedNumberTextView<Content>: View, Animatable where Content: View {
    private var value: Double
    @ViewBuilder private let content: (Int) -> Content

    init(_ value: Int, content: @escaping (Int) -> Content) {
        self.value = Double(value)
        self.content = content
    }

    var animatableData: Double {
        get { value }
        set { value = newValue }
    }

    var body: some View {
        content(Int(value))
    }
}
