//
//  UserService.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

protocol UserService {
    func getUser() async -> User
}

class DefaultUserService: UserService {
    // TODO: At a later date build out the correct generic function to pull data from a URL and store it for now just return the user object
    func getUser() async -> User {
        // TODO: This is mocked. Need to pull from DB / API on Entity
        // Mocked for now whilst we are only dealing with users
        let jackIceCreamDataPoints = [
            IceCreamData(month: "Jan", points: 5),
            IceCreamData(month: "Feb", points: 11),
            IceCreamData(month: "Mar", points: -2),
            IceCreamData(month: "Apr", points: 2),
            IceCreamData(month: "May", points: 9),
            IceCreamData(month: "Jun", points: -5),
            IceCreamData(month: "Jul", points: 10),
        ]

        let mummyIceCreamDataPoints = [
            IceCreamData(month: "Jan", points:11),
            IceCreamData(month: "Feb", points: 9),
            IceCreamData(month: "Mar", points: 4),
            IceCreamData(month: "Apr", points: 10),
            IceCreamData(month: "May", points: 23),
            IceCreamData(month: "Jun", points: 35),
            IceCreamData(month: "Jul", points: 50),
        ]

        let chrisIceCreamDataPoints = [
            IceCreamData(month: "Jan", points:0),
            IceCreamData(month: "Feb", points: -10),
            IceCreamData(month: "Mar", points: -99),
            IceCreamData(month: "Apr", points: -1000),
            IceCreamData(month: "May", points: -3000),
            IceCreamData(month: "Jun", points: -3500),
            IceCreamData(month: "Jul", points: -50000),
        ]

        var me = User(dataPoints: jackIceCreamDataPoints, name: "Jack", iceCreamPoints: 1000, type: .child)
        let jack = User(dataPoints: jackIceCreamDataPoints, name: "Jack", iceCreamPoints: 1000, type: .child)
        let jem = User(dataPoints: mummyIceCreamDataPoints, name: "Mummy", iceCreamPoints: 450, type: .child)
        let chris = User(dataPoints: chrisIceCreamDataPoints, name: "Chris", iceCreamPoints: -10000000, type: .child)

        me.children.append(jack)
        me.children.append(jem)
        me.children.append(chris)

        return me
    }

}
