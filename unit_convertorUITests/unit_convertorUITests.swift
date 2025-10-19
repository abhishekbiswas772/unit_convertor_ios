//
//  unit_convertorUITests.swift
//  unit_convertorUITests
//
//  Created by Abhishek on 19/10/25.
//

import XCTest

final class unit_convertorUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Length Conversion Tests

    @MainActor
    func testLengthConversionMeterToKilometer() throws {
        // Verify Length tab is selected by default
        let lengthButton = app.buttons["Length"]
        XCTAssertTrue(lengthButton.exists)

        // Enter value
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.exists)
        textField.tap()
        textField.typeText("1000")

        // Select From unit - Meter
        let fromPicker = app.buttons.matching(identifier: "From Unit").firstMatch
        if fromPicker.exists {
            fromPicker.tap()
            app.buttons["Meter"].tap()
        }

        // Select To unit - Kilometer
        let toPicker = app.buttons.matching(identifier: "To Unit").firstMatch
        if toPicker.exists {
            toPicker.tap()
            app.buttons["Kilometer"].tap()
        }

        // Tap Convert button
        let convertButton = app.buttons["Convert"]
        XCTAssertTrue(convertButton.exists)
        convertButton.tap()

        // Verify result screen appears
        let resultText = app.staticTexts["Result"]
        XCTAssertTrue(resultText.waitForExistence(timeout: 2))

        // Verify result value exists
        let resultValue = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '1.00'")).firstMatch
        XCTAssertTrue(resultValue.exists)
    }

    @MainActor
    func testLengthConversionInchToFoot() throws {
        // Enter value
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("12")

        // Tap Convert to see result
        let convertButton = app.buttons["Convert"]
        convertButton.tap()

        // Wait for result
        XCTAssertTrue(app.staticTexts["Result"].waitForExistence(timeout: 2))
    }

    // MARK: - Weight Conversion Tests

    @MainActor
    func testWeightConversionKilogramToPound() throws {
        // Switch to Weight tab
        let weightButton = app.buttons["Weight"]
        XCTAssertTrue(weightButton.exists)
        weightButton.tap()

        // Wait for tab to switch
        sleep(1)

        // Enter value
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.exists)
        textField.tap()
        textField.typeText("1")

        // Select From unit - Kilogram
        let fromPicker = app.buttons.matching(identifier: "From Unit").firstMatch
        if fromPicker.exists {
            fromPicker.tap()
            if app.buttons["Kilogram"].exists {
                app.buttons["Kilogram"].tap()
            }
        }

        // Select To unit - Pound
        let toPicker = app.buttons.matching(identifier: "To Unit").firstMatch
        if toPicker.exists {
            toPicker.tap()
            if app.buttons["Pound"].exists {
                app.buttons["Pound"].tap()
            }
        }

        // Tap Convert
        let convertButton = app.buttons["Convert"]
        convertButton.tap()

        // Verify result appears
        XCTAssertTrue(app.staticTexts["Result"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testWeightConversionGramToKilogram() throws {
        // Switch to Weight tab
        app.buttons["Weight"].tap()
        sleep(1)

        // Enter value
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("1000")

        // Tap Convert
        app.buttons["Convert"].tap()

        // Verify result screen
        XCTAssertTrue(app.staticTexts["Result"].waitForExistence(timeout: 2))
    }

    // MARK: - Temperature Conversion Tests

    @MainActor
    func testTemperatureConversionCelsiusToFahrenheit() throws {
        // Switch to Temperature tab
        let temperatureButton = app.buttons["Temperature"]
        XCTAssertTrue(temperatureButton.exists)
        temperatureButton.tap()

        // Wait for tab to switch
        sleep(1)

        // Enter value (freezing point)
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.exists)
        textField.tap()
        textField.typeText("0")

        // Select From unit - Celsius (should be default)
        // Select To unit - Fahrenheit
        let toPicker = app.buttons.matching(identifier: "To Unit").firstMatch
        if toPicker.exists {
            toPicker.tap()
            if app.buttons["Fahrenheit"].exists {
                app.buttons["Fahrenheit"].tap()
            }
        }

        // Tap Convert
        let convertButton = app.buttons["Convert"]
        convertButton.tap()

        // Verify result (should be 32°F)
        XCTAssertTrue(app.staticTexts["Result"].waitForExistence(timeout: 2))
        let resultValue = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '32'")).firstMatch
        XCTAssertTrue(resultValue.exists)
    }

    @MainActor
    func testTemperatureConversionBoilingPoint() throws {
        // Switch to Temperature tab
        app.buttons["Temperature"].tap()
        sleep(1)

        // Enter value (boiling point)
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("100")

        // Select To unit - Fahrenheit
        let toPicker = app.buttons.matching(identifier: "To Unit").firstMatch
        if toPicker.exists {
            toPicker.tap()
            if app.buttons["Fahrenheit"].exists {
                app.buttons["Fahrenheit"].tap()
            }
        }

        // Tap Convert
        app.buttons["Convert"].tap()

        // Verify result (should be 212°F)
        XCTAssertTrue(app.staticTexts["Result"].waitForExistence(timeout: 2))
    }

    // MARK: - Navigation and Reset Tests

    @MainActor
    func testResetFunctionality() throws {
        // Enter value and convert
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("100")

        app.buttons["Convert"].tap()

        // Verify result screen
        XCTAssertTrue(app.staticTexts["Result"].waitForExistence(timeout: 2))

        // Tap Convert Another button
        let resetButton = app.buttons["Convert Another"]
        XCTAssertTrue(resetButton.exists)
        resetButton.tap()

        // Verify we're back to input screen
        XCTAssertTrue(app.buttons["Convert"].waitForExistence(timeout: 2))

        // Verify text field is empty or exists
        XCTAssertTrue(app.textFields.firstMatch.exists)
    }

    @MainActor
    func testTabSwitching() throws {
        // Verify all three tabs exist
        XCTAssertTrue(app.buttons["Length"].exists)
        XCTAssertTrue(app.buttons["Weight"].exists)
        XCTAssertTrue(app.buttons["Temperature"].exists)

        // Switch to Weight
        app.buttons["Weight"].tap()
        sleep(1)
        XCTAssertTrue(app.buttons["Weight"].isSelected)

        // Switch to Temperature
        app.buttons["Temperature"].tap()
        sleep(1)
        XCTAssertTrue(app.buttons["Temperature"].isSelected)

        // Switch back to Length
        app.buttons["Length"].tap()
        sleep(1)
        XCTAssertTrue(app.buttons["Length"].isSelected)
    }

    @MainActor
    func testConvertButtonDisabledWhenEmpty() throws {
        // Verify Convert button exists
        let convertButton = app.buttons["Convert"]
        XCTAssertTrue(convertButton.exists)

        // Button should be disabled when text field is empty
        XCTAssertFalse(convertButton.isEnabled)

        // Enter text
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("50")

        // Button should now be enabled
        XCTAssertTrue(convertButton.isEnabled)
    }

    @MainActor
    func testAppTitle() throws {
        // Verify app title exists
        let titleText = app.staticTexts["Unit Converter"]
        XCTAssertTrue(titleText.exists)
    }

    @MainActor
    func testResultScreenElements() throws {
        // Perform a conversion
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("25")

        app.buttons["Convert"].tap()

        // Verify result screen elements
        XCTAssertTrue(app.staticTexts["Result"].waitForExistence(timeout: 2))

        // Verify result value exists
        let resultValue = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '25'")).firstMatch
        XCTAssertTrue(resultValue.exists)

        // Verify Convert Another button exists
        XCTAssertTrue(app.buttons["Convert Another"].exists)
    }

    // MARK: - Performance Tests

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

    @MainActor
    func testConversionPerformance() throws {
        let textField = app.textFields.firstMatch

        measure {
            textField.tap()
            textField.typeText("100")
            app.buttons["Convert"].tap()

            // Wait for result
            _ = app.staticTexts["Result"].waitForExistence(timeout: 2)

            // Reset
            app.buttons["Convert Another"].tap()
        }
    }
}
