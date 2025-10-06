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
                    .sheet(isPresented: $presenter.showSignUp) {
                        SignUpSheetView(presenter: presenter)
                    }
                    .sheet(isPresented: $presenter.requiringLogIn) {
                        LoginSheet(presenter: presenter, requiringLogIn: $presenter.requiringLogIn)
                    }
                    .accessibilityIdentifier("initial-tab-indicator")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mainBackground)
        }
    }
}

// TODO: Break this out into its own module
struct SignUpSheetView: View {
    @State var presenter: RootContainerPresenter

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()

                Text("Sign Up")
                    .padding(.top, Style.fullPadding)
                    .font(CustomFont.subHeaderFont)

                Spacer()
            }

            Spacer()

            Text("Signup as a new parent. When you are registered you will be able to register your own children.")
                .padding(.top, Style.fullPadding)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(4)
                .font(CustomFont.regularFontBody)

            ValidationTextField(placeholder: String(localized: "Nickname"),
                                icon: "person",
                                resultString: $presenter.signupUserName,
                                regExValidation: presenter.isValidEmail)

            ValidationTextField(placeholder: String(localized: .loginTextfieldEmailLabel),
                                icon: "envelope",
                                resultString: $presenter.signUpEmail,
                                regExValidation: presenter.isValidEmail)

            ValidationTextField(placeholder: String(localized: .loginTextfieldPasswordLabel),
                                icon: "lock",
                                resultString: $presenter.signUpPassword,
                                isSecure: true,
                                regExValidation: presenter.isValidPassword)

            Button("Sign Up") {
                // TODO: Initial not logging in just to get past the login screen
                /*
                requiringLogIn = false
                Task {
                    await presenter.fetch()
                }
                */
            }
            .frame(maxWidth: .infinity)
            .padding(.top, Style.fullPadding)
            .buttonStyle(CustomButton())

            Spacer()
        }
        .padding(Style.fullPadding)
        .interactiveDismissDisabled()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cellBackground)
        .presentationDetents([.medium, .medium])
        .presentationDragIndicator(.hidden)
    }
}

// TODO: break this out into its own Module
struct LoginSheet: View {

    @State var presenter: RootContainerPresenter
    @Binding var requiringLogIn: Bool
    @Environment(\.dismiss) var dismiss

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

    var body: some View {
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

            ValidationTextField(placeholder: String(localized: .loginTextfieldEmailLabel),
                                icon: "envelope",
                                resultString: $presenter.email,
                                regExValidation: presenter.isValidEmail)

            ValidationTextField(placeholder: String(localized: .loginTextfieldPasswordLabel),
                                icon: "lock",
                                resultString: $presenter.password,
                                isSecure: true,
                                regExValidation: presenter.isValidPassword)

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
        .interactiveDismissDisabled()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cellBackground)
        .presentationDetents([.medium, .medium])
        .presentationDragIndicator(.hidden)
        .environment(\.openURL, OpenURLAction { url in
            // TODO: Test this
            if url.absoluteString == "://sign_up" {
                presenter.showSignUpModule()
            }
            return .handled
        })
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
