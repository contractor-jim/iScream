//
//  ChildDashboardUITests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

import XCTest

final class ChildDashboardUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }

    @MainActor
    func testChildDashboardCanSeeUI() throws {
        // TODO: Need to add mocks here
        let app = XCUIApplication()
        app.launchArguments.append("USER_CHILD")
        app.activate()

        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Welcome Daddy"]/*[[".otherElements.staticTexts[\"Welcome Daddy\"]",".staticTexts[\"Welcome Daddy\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["- 1000 Points"]/*[[".otherElements.staticTexts[\"- 1000 Points\"]",".staticTexts[\"- 1000 Points\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.otherElements["May"]/*[[".otherElements.otherElements[\"May\"]",".otherElements[\"May\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.otherElements["child-dashboard-chart-view"].waitForExistence(timeout: 3.0))
    }
}
