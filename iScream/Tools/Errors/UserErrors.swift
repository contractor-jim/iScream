//
//  UserErrors.swift
//  iScream
//
//  Created by James Woodbridge on 07/11/2025.
//
// TODO: Test this
enum UserError: Error {
    case userServiceNotFound
    case loggedInUserNotFound
    case registrationFailed
    case loginFailed
    case createProfileFailed
    case fetchUserProfileFailed
}
// TODO: Need to add these strings to the strings file and test
extension UserError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userServiceNotFound:
            return "User service not found. Dev Error"
        case .loggedInUserNotFound:
            return "User not logged in. Please login again."
        case .registrationFailed:
            return "User registration failed. Please try again"
        case .loginFailed:
            return "Login failed. Please try again."
        case .createProfileFailed:
            return "Failed to create the users profile. Please try again."
        case .fetchUserProfileFailed:
            return "Failed to fetch user profile. Please try again."
        }
    }
}
