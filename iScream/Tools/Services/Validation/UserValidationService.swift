//
//  UserValidationService.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import Foundation

protocol UserValidationService {
    func isValidEmail(email: String) -> String
    func isValidPassword(password: String) -> String
    func isValidNickName(userName: String) -> String
}

class DefaultUserValidationService: GenericService, UserValidationService {

    func isValidEmail(email: String) -> String {
        if email.isEmpty {
            return String(localized: .validationMissingEmailMessage)
        }

        let regex = "^[A-Z0-9a-z._%+-]{1,}@[A-Za-z0-9-]{1,}(\\.[A-Za-z]{2,15}){1,2}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: email) {
            return String(localized: .validationEmailIncorrectMessage)
        }

        return ""
    }

    func isValidPassword(password: String) -> String {
        if password.isEmpty {
            return String(localized: .validationMissingPasswordMessage)
        }

        let regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*?[#?!@$%^&*-_]).{8,24}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: password) {
            return String(localized: .validationPasswordIncorrectMessage)
        }

        return ""
    }

    func isValidNickName(userName: String) -> String {
        if userName.isEmpty {
            return String(localized: .validationMissingNicknameMessage)
        }

        let regex = "^[A-Za-z]{2,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: userName) {
            return String(localized: .validationIncorrectNicknameMessage)
        }

        return ""
    }
}
