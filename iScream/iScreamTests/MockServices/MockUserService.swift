//
//  MockUserService.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
class MockUserService: UserService {

    var mockUser: User?

    func getUser() async -> User {
        return mockUser ?? User(dataPoints: [],
                                openBounties: [],
                                completedBounties: [],
                                name: "",
                                iceCreamPoints: 0)
    }
}
