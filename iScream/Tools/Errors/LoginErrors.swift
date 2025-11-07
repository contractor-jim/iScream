//
//  LoginErrors.swift
//  iScream
//
//  Created by James Woodbridge on 06/11/2025.
//

import Foundation
// TODO: Test this
enum LoginError: Error {
    case loginDetailsIncorrect
    case failedToLoadProfile
}

extension LoginError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .failedToLoadProfile:
            return "Failed to load the user profile"
        case .loginDetailsIncorrect:
            return "Username or password incorrect"
        }
    }
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToLoadProfile:
            return "Failed to load the user profile"
        case .loginDetailsIncorrect:
            return "Username or password incorrect"
        }
    }
}
