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

    @Test("POSITIVE - Service builder contains correct default services") func testInitAppServiceBuilder() throws {
        // Make sure that when new services are added to the graph this test fails to indicate test should be updated
        #expect(AppServiceBuilder.defaultContainer.description == """
        [
            { Service: GenericService, Name: "DefaultSupaBaseService", Factory: Resolver -> GenericService, ObjectScope: graph },
            { Service: GenericService, Name: "DefaultUserService", Factory: Resolver -> GenericService, ObjectScope: graph },
            { Service: GenericService, Name: "DefaultUserValidationService", Factory: Resolver -> GenericService, ObjectScope: graph }
        ]
        """)
        // Check out actual services exist in the graph
        #expect(AppServiceBuilder.defaultContainer.resolve(GenericService.self, name: "DefaultUserService") != nil)
        #expect(AppServiceBuilder.defaultContainer.resolve(GenericService.self, name: "DefaultUserValidationService") != nil)
        #expect(AppServiceBuilder.defaultContainer.resolve(GenericService.self, name: "DefaultSupaBaseService") != nil)
    }
}
