//
//  BountyUITests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

import XCTest

final class BountyUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }

    @MainActor
    func testChildCanNavigateToAndSeeBounties() throws {
        // TODO: Need to add mocks here
        let app = XCUIApplication()
        app.launchArguments.append("USER_CHILD")
        app.activate()

        app/*@START_MENU_TOKEN@*/.buttons.images["ice.cream.coin"]/*[[".images.matching(identifier: \"ice.cream.coin\").element(boundBy: 0)",".buttons[\"Bounties\"].images.firstMatch",".buttons.images[\"ice.cream.coin\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Open Bounties"]/*[[".otherElements.staticTexts[\"Open Bounties\"]",".staticTexts[\"Open Bounties\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        // XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Clean your room"]/*[[".otherElements.staticTexts[\"Clean your room\"]",".staticTexts[\"Clean your room\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Mow the lawn"]/*[[".otherElements.staticTexts[\"Mow the lawn\"]",".staticTexts[\"Mow the lawn\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Take out the bins"]/*[[".otherElements.staticTexts[\"Take out the bins\"]",".staticTexts[\"Take out the bins\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Do your math homework"]/*[[".otherElements.staticTexts[\"Do your math homework\"]",".staticTexts[\"Do your math homework\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Completed Bounties"]/*[[".otherElements.staticTexts[\"Completed Bounties\"]",".staticTexts[\"Completed Bounties\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Do Geography Homework"]/*[[".otherElements.staticTexts[\"Do Geography Homework\"]",".staticTexts[\"Do Geography Homework\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Tidy up your toys"]/*[[".otherElements.staticTexts[\"Tidy up your toys\"]",".staticTexts[\"Tidy up your toys\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        // TODO: These don't even show up, are the old UITest shenanigans still about?
        // XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Be a good boy for Nanny"]/*[[".otherElements.staticTexts[\"Be a good boy for Nanny\"]",".staticTexts[\"Be a good boy for Nanny\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 4.0))
        // XCTAssertTrue(app/*@START_MENU_TOKEN@*/.otherElements.staticTexts["Eat all your dinner"]/*[[".otherElements.staticTexts[\"Eat all your dinner\"]",".staticTexts[\"Eat all your dinner\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 4.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Bounties"]/*[[".navigationBars",".staticTexts.firstMatch",".staticTexts[\"Bounties\"]"],[[[-1,2],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 4.0))
    }

    @MainActor
    func testParentCanNavigateToAndSeeBounties() throws {
        // TODO: Need to add mocks here
        let app = XCUIApplication()
        app.launchArguments.append("USER_PARENT")
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons.images["ice.cream.coin"]/*[[".images.matching(identifier: \"ice.cream.coin\").element(boundBy: 0)",".buttons[\"Bounties\"].images.firstMatch",".buttons.images[\"ice.cream.coin\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Open Bounties"]/*[[".otherElements.staticTexts[\"Open Bounties\"]",".staticTexts[\"Open Bounties\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Clean your room"]/*[[".otherElements.staticTexts[\"Clean your room\"]",".staticTexts[\"Clean your room\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Mow the lawn"]/*[[".otherElements.staticTexts[\"Mow the lawn\"]",".staticTexts[\"Mow the lawn\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Take out the bins"]/*[[".otherElements.staticTexts[\"Take out the bins\"]",".staticTexts[\"Take out the bins\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Do your math homework"]/*[[".otherElements.staticTexts[\"Do your math homework\"]",".staticTexts[\"Do your math homework\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Completed Bounties"]/*[[".otherElements.staticTexts[\"Completed Bounties\"]",".staticTexts[\"Completed Bounties\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Do Geography Homework"]/*[[".otherElements.staticTexts[\"Do Geography Homework\"]",".staticTexts[\"Do Geography Homework\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Tidy up your toys"]/*[[".otherElements.staticTexts[\"Tidy up your toys\"]",".staticTexts[\"Tidy up your toys\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        // TODO: These don't even show up, are the old UITest schenanigans still about?
        // XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Be a good boy for Nanny"]/*[[".otherElements.staticTexts[\"Be a good boy for Nanny\"]",".staticTexts[\"Be a good boy for Nanny\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        // XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Eat all your dinner"]/*[[".otherElements.staticTexts[\"Eat all your dinner\"]",".staticTexts[\"Eat all your dinner\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Bounties"]/*[[".navigationBars",".staticTexts.firstMatch",".staticTexts[\"Bounties\"]"],[[[-1,2],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3.0))
    }
}
