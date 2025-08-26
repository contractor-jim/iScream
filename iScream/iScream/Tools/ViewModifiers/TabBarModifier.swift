//
//  TabBarModifier.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct TabBarModifier: ViewModifier {
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .navBackground
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func tabBarModifier() -> some View {
        modifier(TabBarModifier())
    }
}
