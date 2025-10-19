//
//  unit_convertorTests.swift
//  unit_convertorTests
//
//  Created by Abhishek on 19/10/25.
//

import Testing
@testable import unit_convertor

struct unit_convertorTests {

    // MARK: - Length Conversion Tests

    @Test func testMillimeterToCentimeter() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 100, fromUnit: .millimeter, toUnit: .centimeter)
        #expect(result == 10.0)
    }

    @Test func testMeterToKilometer() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 1000, fromUnit: .meter, toUnit: .kilometer)
        #expect(result == 1.0)
    }

    @Test func testInchToFoot() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 12, fromUnit: .inch, toUnit: .foot)
        #expect(abs(result - 1.0) < 1e-9)
    }

    @Test func testMileToKilometer() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 1, fromUnit: .mile, toUnit: .kilometer)
        let expected = 1.60934
        #expect(abs(result - expected) < 0.001)
    }

    @Test func testYardToMeter() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 1, fromUnit: .yard, toUnit: .meter)
        let expected = 0.9144
        #expect(abs(result - expected) < 0.0001)
    }

    @Test func testSameLengthUnit() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 100, fromUnit: .meter, toUnit: .meter)
        #expect(result == 100.0)
    }

    @Test func testZeroLength() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 0, fromUnit: .meter, toUnit: .kilometer)
        #expect(result == 0.0)
    }

    // MARK: - Weight Conversion Tests

    @Test func testMilligramToGram() async throws {
        let result = convertWeightFromUnitOneToUnitTwo(value: 1000, fromUnit: .milligram, toUnit: .gram)
        #expect(result == 1.0)
    }

    @Test func testKilogramToPound() async throws {
        let result = convertWeightFromUnitOneToUnitTwo(value: 1, fromUnit: .kilogram, toUnit: .pound)
        let expected = 2.20462
        #expect(abs(result - expected) < 0.001)
    }

    @Test func testOunceToGram() async throws {
        let result = convertWeightFromUnitOneToUnitTwo(value: 1, fromUnit: .ounce, toUnit: .gram)
        let expected = 28.3495
        #expect(abs(result - expected) < 0.001)
    }

    @Test func testPoundToKilogram() async throws {
        let result = convertWeightFromUnitOneToUnitTwo(value: 2.20462, fromUnit: .pound, toUnit: .kilogram)
        #expect(abs(result - 1.0) < 0.001)
    }

    @Test func testSameWeightUnit() async throws {
        let result = convertWeightFromUnitOneToUnitTwo(value: 50, fromUnit: .gram, toUnit: .gram)
        #expect(result == 50.0)
    }

    @Test func testZeroWeight() async throws {
        let result = convertWeightFromUnitOneToUnitTwo(value: 0, fromUnit: .kilogram, toUnit: .pound)
        #expect(result == 0.0)
    }

    // MARK: - Temperature Conversion Tests

    @Test func testCelsiusToFahrenheit() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(0, from: .celsius, to: .fahrenheit)
        #expect(result == 32.0)
    }

    @Test func testFahrenheitToCelsius() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(32, from: .fahrenheit, to: .celsius)
        #expect(result == 0.0)
    }

    @Test func testCelsiusToKelvin() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(0, from: .celsius, to: .kelvin)
        #expect(result == 273.15)
    }

    @Test func testKelvinToCelsius() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(273.15, from: .kelvin, to: .celsius)
        #expect(abs(result - 0.0) < 0.001)
    }

    @Test func testFahrenheitToKelvin() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(32, from: .fahrenheit, to: .kelvin)
        #expect(abs(result - 273.15) < 0.001)
    }

    @Test func testKelvinToFahrenheit() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(273.15, from: .kelvin, to: .fahrenheit)
        #expect(abs(result - 32.0) < 0.001)
    }

    @Test func testBoilingPoint() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(100, from: .celsius, to: .fahrenheit)
        #expect(result == 212.0)
    }

    @Test func testSameTemperatureUnit() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(25, from: .celsius, to: .celsius)
        #expect(result == 25.0)
    }

    // MARK: - Edge Cases and Large Numbers

    @Test func testLargeNumberLength() async throws {
        let result = convertLengthFromUnitOneToUnitTwo(value: 1000000, fromUnit: .millimeter, toUnit: .kilometer)
        #expect(result == 1.0)
    }

    @Test func testSmallDecimalWeight() async throws {
        let result = convertWeightFromUnitOneToUnitTwo(value: 0.001, fromUnit: .kilogram, toUnit: .gram)
        #expect(result == 1.0)
    }

    @Test func testNegativeTemperature() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(-40, from: .celsius, to: .fahrenheit)
        #expect(result == -40.0) // -40°C = -40°F
    }

    @Test func testAbsoluteZero() async throws {
        let result = convertTemperatureFromUnitOneToUnitTwo(-273.15, from: .celsius, to: .kelvin)
        #expect(abs(result - 0.0) < 0.001)
    }

}
