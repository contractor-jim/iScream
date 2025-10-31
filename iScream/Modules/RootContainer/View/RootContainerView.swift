//
//  RootContainerView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct RootContainerView: View, GenericView {

    @State var presenter: RootContainerPresenter
    @Environment(\.dismiss) var dismiss

    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? RootContainerPresenter else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        self.presenter = presenter
    }

    var body: some View {
        if let profile = presenter.userProfile {
            LoggedInTabBarView(profile: profile, presenter: presenter)
        } else {
            VStack {
                ProgressView()
                    .onAppear {
                        Task {
                            // TODO: Need to check if a user is logged in, token needs refreshing e.t.c.
                            // await presenter.fetch()
                        }
                    }
                    .sheet(isPresented: $presenter.requiringLogIn) {
                        ViperContainerBuilder.buildLoginView()
                        .onDisappear {
                            Task {
                                // TODO: Need to check if a user is logged in, token needs refreshing e.t.c.
                                await presenter.fetch()
                            }
                        }
                    }
                    .accessibilityIdentifier("initial-tab-indicator")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mainBackground)
        }
    }
}

struct LoggedInTabBarView: View {
    let profile: Profile
    let presenter: RootContainerPresenter

    var body: some View {
        TabView {
            Tab("general.title.people", systemImage: "person.fill") {
                if profile.type == UserType.parent {
                    ViperContainerBuilder.buildParentListChildrenViewBuilder()
                        .accessibilityIdentifier("parent-children-list-view")
                } else if profile.type == UserType.child {
                    ViperContainerBuilder.buildChildDashboardView()
                        .accessibilityIdentifier("children-list-view")
                }
            }
            .accessibilityIdentifier("parent-tab-bar-item-1")

            Tab {
                ViperContainerBuilder.buildBountyView()
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
                Text("Achievements")
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
