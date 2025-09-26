//
//  RootContainerPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

protocol RootContainerPresenterProtocol: GenericPresenter {
    // Observed Properties
    var user: User? { get }
    var email: String { get set }
    var password: String { get set }

    // Validation
    func isValidEmail() -> String
    func isValidPassword() -> String

    func fetch() async
    func getBountyBadgeCount() -> Int

}

@Observable
class RootContainerPresenter: GenericPresenterImp<RootContainerInteractor, RootContainerRouter>,
                              RootContainerPresenterProtocol, Observable {
    var user: User?
    var email: String = ""
    var password: String = ""
    var requiringLogIn: Bool = true

    func isValidEmail() -> String {
        if email.isEmpty {
            return "Missing Email"
        }

        let regex = "^[A-Z0-9a-z._%+-]{1,}@[A-Za-z0-9-]{1,}(\\.[A-Za-z]{2,15}){1,2}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: email) {
            return "Invalid Email"
        }

        return ""
    }

    // TODO: Test this
    func isValidPassword() -> String {
        if password.isEmpty {
            return "Missing Password"
        }

        let regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)

        if !predicate.evaluate(with: password) {
            return "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"
        }

        return ""
    }

    func fetch() async {
        user = await interactor.fetchMyUser()
    }

    func getBountyBadgeCount() -> Int {
        guard let user else {
            return 0
        }

        if user.type == UserType.child.rawValue {
            return user.openBounties.count
        } else if user.type == UserType.parent.rawValue {
            // TODO: Need another state called pending complete to tell the parent of bounties the child claims to have completed
            return 0
        }

        return 0
    }
}
