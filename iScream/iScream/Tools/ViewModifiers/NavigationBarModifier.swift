//
//  NavigationBarModifier.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    init() {

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .navBackground

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: CustomFont.headerFontName, size: 20)!]

        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: CustomFont.headerFontName, size: 32)!]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationBarModifier() -> some View {
        modifier(NavigationBarModifier())
    }
}
