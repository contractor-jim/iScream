//
//  MockUserService.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

@testable import iScream
import Foundation

class MockUserService: GenericService, UserService {

    var mockUser: User?

    func getUser() async throws -> iScream.User? {
        return mockUser ?? User(id: UUID(),
                                dataPoints: [],
                                bounties: [],
                                name: "",
                                iceCreamPoints: 0,
                                negativeIceCreamPoints: 0,
                                type: "parent")
    }
}

extension MockUserService: Equatable {
    static func == (lhs: MockUserService, rhs: MockUserService) -> Bool {
        lhs.mockUser == rhs.mockUser
    }
}
