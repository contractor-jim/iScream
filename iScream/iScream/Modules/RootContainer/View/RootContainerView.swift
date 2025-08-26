//
//  RootContainerView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct RootContainerView: View {

    @State var presenter: RootContainerPresenter!
    // TODO: Put these strings into a strings file
    var body: some View {
        TabView {
            Tab("People", systemImage: "person.fill") {
                Text("Page 1")
            }

            Tab("Bounties", systemImage: "trophy.fill") {
                Text("Page 2")
            }
            .badge(10)
        }
         .navigationBarModifier()
         .tabBarModifier()
         .toolbarBackground(.navBackground)
         .font(.custom(CustomFont.regularFontName, size: 18))
         .tint(.white)
    }
}
