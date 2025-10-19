//
//  Item.swift
//  unit_convertor
//
//  Created by Abhishek on 19/10/25.
//

import Foundation

enum Length : String,CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case millimeter = "millimeter"
    case centimeter = "centimeter"
    case meter = "meter"
    case kilometer = "kilometer"
    case inch = "inch"
    case foot = "foot"
    case yard = "yard"
    case mile = "mile"
}

enum Weight : String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case milligram = "milligram"
    case gram = "gram"
    case kilogram = "kilogram"
    case ounce = "ounce"
    case pound = "pound"
}


enum Temperature  : String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
    case kelvin = "kelvin"
}


func convertLengthFromUnitOneToUnitTwo(value : Double, fromUnit: Length, toUnit: Length) -> Double {
    let toMeters : [Length : Double] = [
        .millimeter : 0.001,
        .centimeter : 0.01,
        .meter : 1,
        .kilometer : 1000,
        .inch : 0.0254,
        .foot : 0.3048,
        .yard : 0.9144,
        .mile : 1609.34
    ]
    guard let fromValueInMeter = toMeters[fromUnit], let toValueInMeter = toMeters[toUnit] else {
        return 0
    }
    return (value * fromValueInMeter)/toValueInMeter
}


func convertWeightFromUnitOneToUnitTwo(value : Double, fromUnit: Weight, toUnit: Weight) -> Double {
    let toKgs : [Weight : Double] = [
        .milligram : 0.000001,
        .gram : 0.001,
        .kilogram : 1,
        .ounce : 0.0283495,
        .pound : 0.453592
    ]
    guard let fromValueInKgs = toKgs[fromUnit], let toValueInKgs = toKgs[toUnit] else {
        return 0
    }
    return (value * fromValueInKgs)/toValueInKgs
}


func convertTemperatureFromUnitOneToUnitTwo(_ value: Double, from fromUnit: Temperature, to toUnit: Temperature) -> Double {
    var celsiusValue: Double = 0.0
    switch fromUnit {
    case .celsius:
        celsiusValue = value
    case .fahrenheit:
        celsiusValue = (value - 32) * 5 / 9
    case .kelvin:
        celsiusValue = value - 273.15
    }

    switch toUnit {
    case .celsius:
        return celsiusValue
    case .fahrenheit:
        return (celsiusValue * 9 / 5) + 32
    case .kelvin:
        return celsiusValue + 273.15
    }
}
