//
//  ParentListChildrenUITests.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import XCTest

final class ParentListChildrenUITests: XCTestCase {
    override func setUpWithError() throws {

        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }

    @MainActor
    func testParentUserCanSeeChildCards() throws {
        // TODO: Need to add mocks here
        let app = XCUIApplication()
        app.launchArguments.append("USER_PARENT")
        app.activate()

        // Ensure the Nav title is set to people
        XCTAssertTrue(
            app.navigationBars.staticTexts["People"].waitForExistence(timeout: 3.0)
        )

        // Ensure the cell is visible
        XCTAssertTrue(
            app.otherElements["parent-dashboard-card-view-Jack"].waitForExistence(timeout: 3.0)
        )

        // Ensure the title is displayed with the users name
        XCTAssertTrue(
            app.staticTexts["Jack"].waitForExistence(timeout: 3.0)
        )

        // Ensure the users positive points are displayed
        // TODO: Add a negative test to ensure the - sign is shown for children with losing points
        XCTAssertTrue(
            app.staticTexts["+15"].waitForExistence(timeout: 3.0)
        )

        // Ensure that the time frame for points owned is shared
        XCTAssertTrue(
            app.staticTexts["Points since Jun"].waitForExistence(timeout: 3.0)
        )

        // Ensure that the users total points are shown
        XCTAssertTrue(
            app/*@START_MENU_TOKEN@*/.staticTexts["1000 Points"]/*[[".otherElements.staticTexts[\"1000 Points\"]",".staticTexts[\"1000 Points\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0)
        )
    }
}
