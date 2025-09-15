//
//  AppServiceBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 12/09/2025.
//

@testable import iScream
import Testing
import Foundation

struct AppServiceBuilderTests {

    @Test("POSITIVE - Corner radius should meet design requirements") func testInitAppServiceBuilder() throws {
        // Make sure that when new services are added to the graph this test fails to indicate test should be updated
        #expect(AppServiceBuilder.defaultContainer.description == """
        [
            { Service: DefaultUserService, Factory: Resolver -> DefaultUserService, ObjectScope: graph }
        ]
        """)
        // Check out actual services exist in the graph
        #expect(AppServiceBuilder.defaultContainer.resolve(DefaultUserService.self) != nil)
    }
}
