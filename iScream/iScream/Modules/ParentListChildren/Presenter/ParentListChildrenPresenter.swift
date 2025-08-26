//
//  ParentListChildrenPresenter.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import SwiftData

protocol ParentListChildrenPresenter {
    var childUsers: [User] { get }
}

@Observable
class ParentListChildrenPresenterImp: ParentListChildrenPresenter, Observable {
    var interactor: ParentListChildrenInteractor!
    var router: ParentListChildrenRouter!

    var childUsers: [User] = []

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

    init(interactor: ParentListChildrenInteractor, router: ParentListChildrenRouter) {
        self.interactor = interactor
        self.router = router

        let jack = User(dataPoints: jackIceCreamDataPoints, name: "Jack", iceCreamPoints: 1000)
        let jem = User(dataPoints: mummyIceCreamDataPoints, name: "Mummy", iceCreamPoints: 450)
        let chris = User(dataPoints: chrisIceCreamDataPoints, name: "Chris", iceCreamPoints: -10000000)

        childUsers.append(jack)
        childUsers.append(jem)
        childUsers.append(chris)
    }
}
