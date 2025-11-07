//
//  UserErrors.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//

import Foundation

enum UserError: Error {
    case userServiceNotFound
    case loggedInUserNotFound
    case registrationFailed
    case loginFailed
    case createProfileFailed
    case fetchUserProfileFailed
}

extension UserError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userServiceNotFound:
            return String(localized: .userErrorUserServiceNotFound)
        case .loggedInUserNotFound:
            return String(localized: .userErrorLoggedInUserNotFound)
        case .registrationFailed:
            return String(localized: .userErrorRegistrationFailed)
        case .loginFailed:
            return String(localized: .userErrorLoginFailed)
        case .createProfileFailed:
            return String(localized: .userErrorCreateProfileFailed)
        case .fetchUserProfileFailed:
            return String(localized: .userErrorFetchUserProfileFailed)
        }
    }
}

extension UserError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userServiceNotFound:
            return String(localized: .userErrorUserServiceNotFound)
        case .loggedInUserNotFound:
            return String(localized: .userErrorLoggedInUserNotFound)
        case .registrationFailed:
            return String(localized: .userErrorRegistrationFailed)
        case .loginFailed:
            return String(localized: .userErrorLoginFailed)
        case .createProfileFailed:
            return String(localized: .userErrorCreateProfileFailed)
        case .fetchUserProfileFailed:
            return String(localized: .userErrorFetchUserProfileFailed)
        }
    }
}
