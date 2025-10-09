//
//  LoginView.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

import SwiftUI

struct LoginView: GenericView, View {

    @State var presenter: LoginPresenter
    @Environment(\.dismiss) var dismiss

    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? LoginPresenter else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        self.presenter = presenter
    }

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

                // TODO: This needs to be a call back to the root containing view with some sort of closure
                dismiss()
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
        .sheet(isPresented: $presenter.showSignUp) {
            ViperContainerBuilder().buildContainerView(
                view: SignUpView.self,
                interactor: SignUpInteractor.self,
                presenter: SignUpPresenter.self,
                entity: SignUpEntity.self,
                router: SignUpRouter.self,
                services: [DefaultUserService.self,
                           DefaultUserValidationService.self])
        }
    }
}
