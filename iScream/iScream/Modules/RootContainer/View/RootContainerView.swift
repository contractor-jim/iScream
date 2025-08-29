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
            Tab("general.title.people", systemImage: "person.fill") {
                // TODO: Switch based on users type parent / child
//                ParentListChildrenDefaultBuilder().buildParentListChildrenView()
//                    .accessibilityIdentifier("parent-children-list-view")
                ChildDashboardDefaultBuilder().buildChildDashboardView()
            }
            .accessibilityIdentifier("parent-tab-bar-item-1")

            Tab("general.title.bounties", systemImage: "trophy.fill") {
                BountyDefaultBuilder().buildBountyView()
            }
            .badge(10)
            .accessibilityIdentifier("parent-tab-bar-item-2")
        }
        .navigationBarModifier()
        .tabBarModifier()
        .toolbarBackground(.navBackground)
        .font(CustomFont.regularFontBody)
        .tint(.white)
        .accessibilityIdentifier("parent-tab-bar")
    }
}
