//
//  LoginErrors.swift
//  iScream
//
//  Created by James Woodbridge on 06/11/2025.
//

import Foundation

enum LoginError: Error {
    case loginDetailsIncorrect
    case failedToLoadProfile
}

extension LoginError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .failedToLoadProfile:
            return String(localized: .loginErrorFailedToLoadProfileError)
        case .loginDetailsIncorrect:
            return String(localized: .loginErrorLoginDetailsIncorrect)
        }
    }
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToLoadProfile:
            return String(localized: .loginErrorFailedToLoadProfileError)
        case .loginDetailsIncorrect:
            return String(localized: .loginErrorLoginDetailsIncorrect)
        }
    }
}
