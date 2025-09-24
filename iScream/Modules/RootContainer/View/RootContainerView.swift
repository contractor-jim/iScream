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

    // TODO: Move this down to a service
    @State var requiringLogIn: Bool = true
    @State var email: String = ""
    @State var password: String = ""

    private var signUpString: AttributedString {
        var result = AttributedString(localized: .loginBodyNonLinkBody)
        result.font = CustomFont.regularFontBody
        result.foregroundColor = .white
        result.backgroundColor = .clear
        return result
    }

    private var signUpStringLink: AttributedString {
        var result = AttributedString("signup here")
        result.font = CustomFont.regularFontBody
        result.foregroundColor = .pink
        result.backgroundColor = .clear
        result.link = URL(string: "://sign_up")
        return result
    }

    private var forgotPasswordString: AttributedString {
        var result = AttributedString(localized: .loginForgotPasswordLabel)
        result.font = CustomFont.regularFontBody
        result.foregroundColor = .blue
        result.backgroundColor = .clear
        result.link = URL(string: "://forgot_password")
        return result
    }

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

    //  All the way to here
    var body: some View {
        if let user = presenter.user {
            LoggedInTabBarView(user: user, presenter: presenter)
        } else {
            VStack {
                ProgressView()
                    .onAppear {
                        Task {
                            // await presenter.fetch()
                        }
                    }
                    .sheet(isPresented: $requiringLogIn) {
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()

                                Text(.generalLabelLogin)
                                    .padding(.top, Style.fullPadding)
                                    .font(CustomFont.subHeaderFont)

                                Spacer()
                            }

                            Spacer()

                            Text(signUpString + signUpStringLink)
                                .padding(.top, Style.fullPadding)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(4)
                                .font(CustomFont.regularFontBody)

                            Text(forgotPasswordString)
                                .padding(.top, Style.fullPadding)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(4)
                                .font(CustomFont.regularFontBody)

                            Spacer()

                            // TODO: Make custom text input fields with error handeling and validation
                            TextField(.loginTextfieldEmailLabel, text: $email)
                                .frame(height: 14)
                                .padding(EdgeInsets(top: 0, leading: 14, bottom: 17, trailing: 14))
                                .cornerRadius(Style.cornerRadius)
                                .padding(.top, Style.fullPadding)
                                .background(.white)
                                .foregroundStyle(Color.mainBackground)
                                .autocapitalization(.none)
                                .clipShape(Capsule())

                            SecureField(.loginTextfieldPasswordLabel, text: $password)
                                .frame(height: 14)
                                .padding(EdgeInsets(top: 0, leading: 14, bottom: 17, trailing: 14))
                                .cornerRadius(Style.cornerRadius)
                                .padding(.top, Style.fullPadding)
                                .background(.white)
                                .foregroundStyle(Color.mainBackground)
                                .autocapitalization(.none)
                                .clipShape(Capsule())

                            Button(.generalLabelLogin) {
                                // TODO: Initial not logging in just to get past the login screen
                                requiringLogIn = false
                                Task {
                                    await presenter.fetch()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, Style.fullPadding)
                            .buttonStyle(CustomButton())
                        }
                        .padding(Style.fullPadding)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.cellBackground)
                        .presentationDetents([.medium, .medium])
                        .presentationDragIndicator(.hidden)
                        .environment(\.openURL, OpenURLAction { url in
                            print(">>> URL \(url)")
                            return .handled
                        })
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
