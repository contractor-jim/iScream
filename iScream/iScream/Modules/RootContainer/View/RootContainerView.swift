//
//  RootContainerView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct RootContainerView: View {

    @State var presenter: RootContainerPresenter!
    var body: some View {
        TabView {
            Tab("tab.title.people", systemImage: "person.fill") {
                Text("Page 1")
            }
            .accessibilityIdentifier("parent-tab-bar-item-1")

            Tab("tab.title.bounties", systemImage: "trophy.fill") {
                Text("Page 2")
            }
            .badge(10)
            .accessibilityIdentifier("parent-tab-bar-item-2")
        }
         .navigationBarModifier()
         .tabBarModifier()
         .toolbarBackground(.navBackground)
         .font(.custom(CustomFont.regularFontName, size: 18))
         .tint(.white)
         .accessibilityIdentifier("parent-tab-bar")
    }
}
