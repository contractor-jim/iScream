//
//  UserServiceTests.swift
//  iScream
//
//  Created by James Woodbridge on 12/09/2025.
//

@testable import iScream
import Testing

struct UserServiceTests {

    @Test("POSITIVE - User service should return the correct user") func testValidUserReturned() throws {
        #expect(false)
        /*
        let service = DefaultUserService()
        // Update from the mocks
        service.mockUser = .mockUser

        // Test data points
        #expect(service.mockUser.dataPoints.count == 2)
        #expect(service.mockUser.dataPoints[0].month == "Jan")
        #expect(service.mockUser.dataPoints[0].points == 5)
        #expect(service.mockUser.dataPoints[1].month == "Feb")
        #expect(service.mockUser.dataPoints[1].points == 11)

        // Test open bounties
        #expect(service.mockUser.openBounties.count == 3)
        var points = 1
        for bounty in service.mockUser.openBounties {
            #expect(bounty.title == "Test\(points)")
            #expect(bounty.points == points)
            #expect(bounty.completed == (points % 2 == 0 ? false : true) )
            points += 1
        }

        points = 1
        for bounty in service.mockUser.completedBounties {
            #expect(bounty.title == "Test\(points)")
            #expect(bounty.points == points)
            #expect(bounty.completed == (points % 2 == 0 ? false : true) )
            points += 1
        }

        #expect(service.mockUser.name == "Test")
        #expect(service.mockUser.iceCreamPoints == 1000)
        #expect(service.mockUser.negativeIceCreamPoints == 50)
        */
    }
}
