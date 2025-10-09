//
//  RootContainerView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct RootContainerView: View, GenericView {

    @State var presenter: RootContainerPresenter

    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? RootContainerPresenter else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        self.presenter = presenter
    }

    var body: some View {
        if let user = presenter.user {
            LoggedInTabBarView(user: user, presenter: presenter)
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
                        ViperContainerBuilder().buildContainerView(
                            view: LoginView.self,
                            interactor: LoginInteractor.self,
                            presenter: LoginPresenter.self,
                            entity: LoginEntity.self,
                            router: LoginRouter.self,
                            services: [DefaultUserService.self,
                                       DefaultUserValidationService.self])
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
    let user: User
    let presenter: RootContainerPresenter

    var body: some View {
        TabView {
            Tab("general.title.people", systemImage: "person.fill") {
                if user.type == UserType.parent.rawValue {
                    ViperContainerBuilder().buildContainerView(
                        view: ParentListChildrenView.self,
                        interactor: ParentListChildrenInteractor.self,
                        presenter: ParentListChildrenPresenter.self,
                        entity: ParentListChildrenEntity.self,
                        router: ParentListChildrenRouter.self,
                        services: [DefaultUserService.self])
                        .accessibilityIdentifier("parent-children-list-view")
                } else if user.type == UserType.child.rawValue {
                    ViperContainerBuilder().buildContainerView(
                        view: ChildDashboardView.self,
                        interactor: ChildDashboardInteractor.self,
                        presenter: ChildDashboardPresenter.self,
                        entity: ChildDashboardEntity.self,
                        router: ChildDashboardRouter.self,
                        services: [DefaultUserService.self])
                        .accessibilityIdentifier("children-list-view")
                }
            }
            .accessibilityIdentifier("parent-tab-bar-item-1")

            Tab {
                ViperContainerBuilder().buildContainerView(
                    view: BountyView.self,
                    interactor: BountyInteractor.self,
                    presenter: BountyPresenter.self,
                    entity: BountyEntity.self,
                    router: BountyRouter.self,
                    services: [DefaultUserService.self])
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
