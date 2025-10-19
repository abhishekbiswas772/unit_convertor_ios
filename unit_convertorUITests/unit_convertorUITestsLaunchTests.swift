//
//  unit_convertorUITestsLaunchTests.swift
//  unit_convertorUITests
//
//  Created by Abhishek on 19/10/25.
//

import XCTest

final class unit_convertorUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify app launches successfully
        XCTAssertTrue(app.exists)

        // Verify main UI elements are present
        XCTAssertTrue(app.staticTexts["Unit Converter"].exists, "App title should exist")
        XCTAssertTrue(app.buttons["Length"].exists, "Length tab should exist")
        XCTAssertTrue(app.buttons["Weight"].exists, "Weight tab should exist")
        XCTAssertTrue(app.buttons["Temperature"].exists, "Temperature tab should exist")

        // Take screenshot of launch screen
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @MainActor
    func testLaunchInDarkMode() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-UIUserInterfaceStyle", "dark"]
        app.launch()

        // Verify app launches in dark mode
        XCTAssertTrue(app.exists)
        XCTAssertTrue(app.staticTexts["Unit Converter"].exists)

        // Take screenshot
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen - Dark Mode"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @MainActor
    func testLaunchInLightMode() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-UIUserInterfaceStyle", "light"]
        app.launch()

        // Verify app launches in light mode
        XCTAssertTrue(app.exists)
        XCTAssertTrue(app.staticTexts["Unit Converter"].exists)

        // Take screenshot
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen - Light Mode"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @MainActor
    func testLaunchWithLengthTab() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify Length tab is selected by default
        let lengthButton = app.buttons["Length"]
        XCTAssertTrue(lengthButton.exists)
        XCTAssertTrue(lengthButton.isSelected)

        // Take screenshot
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen - Length Tab"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @MainActor
    func testLaunchWithWeightTab() throws {
        let app = XCUIApplication()
        app.launch()

        // Switch to Weight tab
        app.buttons["Weight"].tap()

        // Take screenshot
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen - Weight Tab"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @MainActor
    func testLaunchWithTemperatureTab() throws {
        let app = XCUIApplication()
        app.launch()

        // Switch to Temperature tab
        app.buttons["Temperature"].tap()

        // Take screenshot
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen - Temperature Tab"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @MainActor
    func testLaunchResultScreen() throws {
        let app = XCUIApplication()
        app.launch()

        // Perform a quick conversion to get to result screen
        let textField = app.textFields.firstMatch
        if textField.exists {
            textField.tap()
            textField.typeText("100")
        }

        let convertButton = app.buttons["Convert"]
        if convertButton.exists {
            convertButton.tap()
        }

        // Wait for result screen
        _ = app.staticTexts["Result"].waitForExistence(timeout: 3)

        // Take screenshot of result screen
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Result Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
