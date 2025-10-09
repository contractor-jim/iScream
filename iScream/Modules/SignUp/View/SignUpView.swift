//
//  SignUpView.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import SwiftUI

struct SignUpView: GenericView, View {

    @State var presenter: SignUpPresenter
    @Environment(\.dismiss) var dismiss

    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? SignUpPresenter else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        self.presenter = presenter
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()

                Text(.signupLabelSignup)
                    .padding(.top, Style.fullPadding)
                    .font(CustomFont.subHeaderFont)

                Spacer()
            }

            Spacer()

            Text(.signupDetailsLabel)
                .padding(.top, Style.fullPadding)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(4)
                .font(CustomFont.regularFontBody)

            ValidationTextField(placeholder: String(localized: .signupNicknameTextfield),
                                icon: "person",
                                resultString: $presenter.userName,
                                regExValidation: presenter.isValidNickName)

            ValidationTextField(placeholder: String(localized: .loginTextfieldEmailLabel),
                                icon: "envelope",
                                resultString: $presenter.email,
                                regExValidation: presenter.isValidEmail)

            ValidationTextField(placeholder: String(localized: .loginTextfieldPasswordLabel),
                                icon: "lock",
                                resultString: $presenter.password,
                                isSecure: true,
                                regExValidation: presenter.isValidPassword)

            Button(.signupLabelSignup) {
                dismiss()
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
