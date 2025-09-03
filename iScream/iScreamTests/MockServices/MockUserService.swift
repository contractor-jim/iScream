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
                                iceCreamPoints: 0,
                                negativeIceCreamPoints: 0)
    }
}

extension MockUserService: Equatable {
    static func == (lhs: MockUserService, rhs: MockUserService) -> Bool {
        // TODO: This needs to be tested
        // TODO: This needs to actually return a user from disk / mocked API
        true
    }
}
