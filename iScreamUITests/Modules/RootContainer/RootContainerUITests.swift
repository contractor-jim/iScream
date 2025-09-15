//
//  RootContainerUITests.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import XCTest

final class RootContainerUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testParentTabBarNavigation() throws {
        // When logged in as a parent i should see the tab bar
        let app = XCUIApplication()
        app.activate()

        XCTAssertTrue(
            app.buttons["People"].waitForExistence(timeout: 3.0)
        )

        XCTAssertTrue(
            app.buttons["Bounties"].waitForExistence(timeout: 3.0)
        )
    }
}
