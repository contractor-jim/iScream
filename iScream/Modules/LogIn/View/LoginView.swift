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
        ZStack {
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

                LoginButton(presenter: presenter)
                /*
                Button(.generalLabelLogin) {
                    //                dismiss()

                    Task {
                        do {
                            try await presenter.loginUser()
                        } catch {

                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, Style.fullPadding)
                .buttonStyle(CustomButton())
                */
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
                ViperContainerBuilder.buildSignUpView()
            }

            if presenter.isLoading {
                VStack(alignment: .center) {
                    Spacer()
                    ProgressView()
                        .tint(.white)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black.opacity(0.7))
            }
        }
    }
}

private struct LoginButton: View {
    @State var presenter: LoginPresenter
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(.generalLabelLogin) {
            presenter.isLoading = true
            Task {
                do {
                    try await presenter.loginUser()
                    presenter.isLoading = false

                    // TODO: Need to get profile e.t.c.
                    dismiss()
                } catch {
                    presenter.loginError = error
                    presenter.errorShown = true
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, Style.fullPadding)
        .buttonStyle(CustomButton())
        .opacity(presenter.validationPassed ? 1.0 : 0.5)
        .disabled(!presenter.validationPassed)
        .alert(.dialogSignupErrorTitle,
               isPresented: $presenter.errorShown,
               presenting: $presenter.loginError,
               actions: { _ in
            Button(.genericButtonOk) {
                presenter.isLoading = false
            }
            .keyboardShortcut(.defaultAction)

        }, message: { signupError in
            Text("\(signupError.wrappedValue!.localizedDescription)")
        })
    }
}
