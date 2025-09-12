//
//  UserService.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import Foundation

protocol UserService: Equatable {
    func getUser() async -> User
}

class DefaultUserService: GenericService, UserService {
    // TODO: This is mocked. Need to pull from DB / API on Entity / Mocks
    var mockUser = User(dataPoints: [],
                        openBounties: [],
                        completedBounties: [],
                        name: "",
                        iceCreamPoints: 0,
                        negativeIceCreamPoints: 0,
                        type: .unknown)

    override init() {

        let jackIceCreamDataPoints = [
            IceCreamData(month: "Jan", points: 5),
            IceCreamData(month: "Feb", points: 11),
            IceCreamData(month: "Mar", points: -2),
            IceCreamData(month: "Apr", points: 2),
            IceCreamData(month: "May", points: 9),
            IceCreamData(month: "Jun", points: -5),
            IceCreamData(month: "Jul", points: 10)
        ]

        let mummyIceCreamDataPoints = [
            IceCreamData(month: "Jan", points: 11),
            IceCreamData(month: "Feb", points: 9),
            IceCreamData(month: "Mar", points: 4),
            IceCreamData(month: "Apr", points: 10),
            IceCreamData(month: "May", points: 23),
            IceCreamData(month: "Jun", points: 35),
            IceCreamData(month: "Jul", points: 50)
        ]

        let chrisIceCreamDataPoints = [
            IceCreamData(month: "Jan", points: 0),
            IceCreamData(month: "Feb", points: -10),
            IceCreamData(month: "Mar", points: -99),
            IceCreamData(month: "Apr", points: -1000),
            IceCreamData(month: "May", points: -3000),
            IceCreamData(month: "Jun", points: -3500),
            IceCreamData(month: "Jul", points: -50000)
        ]

        let openBountyData = [
            Bounty(title: "Clean your room", points: 10, completed: false),
            Bounty(title: "Mow the lawn", points: 20, completed: false),
            Bounty(title: "Take out the bins", points: 2, completed: false),
            Bounty(title: "Do your math homework", points: 5, completed: false)
        ]

        let completedBountyData = [
            Bounty(title: "Do Geography Homework", points: 5, completed: true),
            Bounty(title: "Tidy up your toys", points: 2, completed: true),
            Bounty(title: "Be a good boy for Nanny", points: 10, completed: true),
            Bounty(title: "Eat all your dinner", points: 2, completed: true)
        ]

        // TODO: This is incorrect as we shouldn't be adding testing code in the app. Add some switching for mock json when the network is built
        let parentTesting = ProcessInfo.processInfo.arguments.contains("USER_PARENT")
        let childTesting = ProcessInfo.processInfo.arguments.contains("USER_CHILD")

        var userType: UserType = .parent
        userType = parentTesting ? .parent : userType
        userType = childTesting ? .child : userType

        mockUser = User(dataPoints: jackIceCreamDataPoints,
                      openBounties: openBountyData,
                      completedBounties: completedBountyData,
                      name: "Daddy",
                      iceCreamPoints: 1000,
                      negativeIceCreamPoints: 200,
                      type: userType)

        let jack = User(dataPoints: jackIceCreamDataPoints,
                        openBounties: openBountyData,
                        completedBounties: completedBountyData,
                        name: "Jack",
                        iceCreamPoints: 1000,
                        negativeIceCreamPoints: 20,
                        type: .child)

        let jem = User(dataPoints: mummyIceCreamDataPoints,
                       openBounties: openBountyData,
                       completedBounties: completedBountyData,
                       name: "Mummy",
                       iceCreamPoints: 450,
                       negativeIceCreamPoints: 20,
                       type: .child)

        let chris = User(dataPoints: chrisIceCreamDataPoints,
                         openBounties: openBountyData,
                         completedBounties: completedBountyData,
                         name: "Chris",
                         iceCreamPoints: -10000000,
                         negativeIceCreamPoints: -10000000,
                         type: .child)

        mockUser.children.append(jack)
        mockUser.children.append(jem)
        mockUser.children.append(chris)
    }

    func getUser() async -> User {
        return mockUser
    }
}

extension DefaultUserService: Equatable {
    static func == (lhs: DefaultUserService, rhs: DefaultUserService) -> Bool {
        rhs.mockUser == rhs.mockUser
    }
}
