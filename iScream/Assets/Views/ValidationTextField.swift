//
//  ValidationTextField.swift
//  iScream
//
//  Created by James Woodbridge on 26/09/2025.
//

import SwiftUI

struct ValidationTextField: View {

    var placeholder: String
    var icon: String?
    @Binding var resultString: String
    @State var isSecure: Bool = false

    @State var errorPromptMessage: String = ""

    var body: some View {

        VStack(alignment: .leading) {
            if errorPromptMessage != "" {
                Text(errorPromptMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .padding([.leading, .trailing], Style.fullPadding)
            }

            HStack {
                if icon != nil {
                    Image(systemName: icon!)
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding(EdgeInsets(top: 0, leading: Style.fullPadding, bottom: 0, trailing: 0))
                }

                if isSecure {
                    SecureField(placeholder, text: $resultString)
                        .padding(EdgeInsets(top: 0,
                                            leading: icon != nil ? 0 : Style.fullPadding,
                                            bottom: 0,
                                            trailing: Style.fullPadding))
                        .frame(height: 14)

                } else {
                    TextField(placeholder, text: $resultString)
                        .padding(EdgeInsets(top: 0,
                                            leading: icon != nil ? 0 : Style.fullPadding,
                                            bottom: 0,
                                            trailing: Style.fullPadding))
                        .frame(height: 14)
                }
            }
            .background(.white)
            .frame(height: 42)
            .cornerRadius(Style.cornerRadius)
            .background(.white)
            .clipShape(Capsule())
            .autocapitalization(.none)
            .foregroundStyle(Color.mainBackground)
        }
        .padding(.top, Style.fullPadding)
    }
}
