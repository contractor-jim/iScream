//
//  RootContainerView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct RootContainerView: View, GenericView {

    @State var presenter: RootContainerPresenter!

    // TODO: This feels wrong here and should not need to be included in the defintion
    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? RootContainerPresenterImp else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        print(">>> INIT TOP presenter P \(presenter)")

        self.presenter = presenter
        print(">>> INIT POST presenter self \(self.presenter)")
    }

    var body: some View {
        // TODO: Need to show login style sheet here
        if let user = presenter.user {
            LoggedInTabBarView(user: user, presenter: presenter)
        } else {
            ProgressView()
                .accessibilityIdentifier("initial-tab-indicator")
                .onAppear {
                Task {
                    await presenter.fetch()
                }
            }
        }
    }
}

struct LoggedInTabBarView: View {
    let user: User
    let presenter: RootContainerPresenter

    var body: some View {
        TabView {
            Tab("general.title.people", systemImage: "person.fill") {
                if user.type == .parent {
                    ParentListChildrenDefaultBuilder().buildParentListChildrenView()
                        .accessibilityIdentifier("parent-children-list-view")
                } else if user.type == .child {
                    ChildDashboardDefaultBuilder().buildChildDashboardView()
                        .accessibilityIdentifier("children-list-view")
                }
            }
            .accessibilityIdentifier("parent-tab-bar-item-1")

            Tab {
                BountyDefaultBuilder().buildBountyView()
                    .accessibilityIdentifier("children-list-view")
            } label: {
                Label {
                  Text("general.title.bounties")
                } icon: {
                  Image("ice.cream.coin")
                }
            }
            .badge(presenter.getBountyBadgeCount())
            .accessibilityIdentifier("parent-tab-bar-item-2")

            Tab("general.title.achievements", systemImage: "trophy.fill") {
                BountyDefaultBuilder().buildBountyView()
                    .accessibilityIdentifier("children-list-view")
            }
            .accessibilityIdentifier("parent-tab-bar-item-3")
        }
        .navigationBarModifier()
        .tabBarModifier()
        .toolbarBackground(.navBackground)
        .font(CustomFont.regularFontBody)
        .tint(.white)
        .accessibilityIdentifier("parent-tab-bar")
    }
}
