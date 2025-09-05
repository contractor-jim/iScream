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
//ChildDashboardUITests.testChildDashboardCanSeeUI()
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

    @MainActor
    func testChildDashboardCanSeeUINaughtyCell() throws {
        // TODO: Need to add mocks here
        let app = XCUIApplication()
        app.launchArguments.append("USER_CHILD")
        app.activate()

        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["child-is-naughty-cell-title"]/*[[".otherElements",".staticTexts[\"Naughty?\"]",".staticTexts[\"child-is-naughty-cell-title\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.otherElements["child-is-naughty-sectormark-Good"]/*[[".otherElements",".otherElements[\"Good\"]",".otherElements[\"child-is-naughty-sectormark-Good\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.otherElements["child-is-naughty-sectormark-Naughty"]/*[[".otherElements",".otherElements[\"Naughty\"]",".otherElements[\"child-is-naughty-sectormark-Naughty\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.otherElements["child-is-naughty-chart-legend"].waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Good"]/*[[".otherElements.staticTexts[\"Good\"]",".staticTexts[\"Good\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Naughty"]/*[[".otherElements.staticTexts[\"Naughty\"]",".staticTexts[\"Naughty\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["Naughty?"].waitForExistence(timeout: 3.0))
    }

    @MainActor
    func testChildDashboardCanSeeUIBountyCell() throws {
        // TODO: Need to add mocks here
        let app = XCUIApplication()
        app.launchArguments.append("USER_CHILD")
        app.activate()

        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["child-bounty-cell-title"]/*[[".otherElements",".staticTexts[\"Bounties\"]",".staticTexts[\"child-bounty-cell-title\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.images["child-bounty-cell-icon"]/*[[".otherElements",".images[\"ice.cream.coin\"]",".images[\"child-bounty-cell-icon\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["child-bounty-cell-completed"]/*[[".otherElements",".staticTexts[\"4\/8 bounties completed\"]",".staticTexts[\"child-bounty-cell-completed\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["4/8 bounties completed"].waitForExistence(timeout: 3.0))
    }

    @MainActor
    func testChildDashboardCanSeeUIAchievementCell() throws {
        // TODO: Need to add mocks here
        let app = XCUIApplication()
        app.launchArguments.append("USER_CHILD")
        app.activate()

        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.images["child-dashboard-achievement-cell-midnight"]/*[[".otherElements.images[\"child-dashboard-achievement-cell-midnight\"]",".images[\"child-dashboard-achievement-cell-midnight\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.images["child-dashboard-achievement-cell-gold"]/*[[".otherElements.images[\"child-dashboard-achievement-cell-gold\"]",".images[\"child-dashboard-achievement-cell-gold\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.images["child-dashboard-achievement-cell-silver"]/*[[".otherElements.images[\"child-dashboard-achievement-cell-silver\"]",".images[\"child-dashboard-achievement-cell-silver\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.images["child-dashboard-achievement-cell-bronze"]/*[[".otherElements.images[\"child-dashboard-achievement-cell-bronze\"]",".images[\"child-dashboard-achievement-cell-bronze\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Achievements"]/*[[".otherElements.staticTexts[\"Achievements\"]",".staticTexts[\"Achievements\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["0"].waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["2"].waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["4"].waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["12"].waitForExistence(timeout: 3.0))
    }
}
