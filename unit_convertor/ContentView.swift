//
//  ContentView.swift
//  unit_convertor
//
//  Created by Abhishek on 19/10/25.
//

import SwiftUI
import SwiftData

struct ContentView : View {

    @State private var currentUnitSelectedTab : Int = 0
    @State private var originalUnitValue : String = ""
    @State private var unitConvertedFrom : String = "millimeter"
    @State private var unitConvertedTo : String = "millimeter"
    @State private var isSubmited : Bool = false
    @State private var result : Double = 0.0


    var body : some View  {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Unit Converter")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)

                    Picker("Category", selection: $currentUnitSelectedTab) {
                        Text("Length").tag(0)
                        Text("Weight").tag(1)
                        Text("Temperature").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
                .background(Color(UIColor.systemBackground))

                if (!self.isSubmited) {
                    UnitSelectionAndValueView(
                        currentUnitSelectedTab: $currentUnitSelectedTab,
                        originalUnitValue: $originalUnitValue,
                        unitConvertedFrom: $unitConvertedFrom,
                        unitConvertedTo: $unitConvertedTo,
                        isSubmited : $isSubmited,
                        result : $result
                    )
                } else {
                    VStack(spacing: 16) {
                        // Result Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Result")
                                .font(.headline)
                                .foregroundColor(.secondary)

                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Text(String(format: "%.2f", result))
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(.primary)

                                Text(unitConvertedTo.capitalized)
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }

                            Divider()
                                .padding(.vertical, 4)

                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Text(originalUnitValue)
                                    .font(.title2)
                                    .foregroundColor(.secondary)

                                Text(unitConvertedFrom.capitalized)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)

                        // Reset Button
                        Button {
                            self.isSubmited = false
                            self.originalUnitValue = ""
                            self.result = 0.0
                        } label: {
                            Text("Convert Another")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top, 8)

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        }
    }
}


struct UnitSelectionAndValueView : View  {
    @Binding public var currentUnitSelectedTab : Int
    @Binding public var originalUnitValue : String
    @Binding public var unitConvertedFrom : String
    @Binding public var unitConvertedTo : String
    @Binding public var isSubmited : Bool
    @Binding public var result : Double
    
    
    
    private func handleSubmit() -> Void {
        if (self.currentUnitSelectedTab == 0){
            guard let fromLength : Length = Length(rawValue: self.unitConvertedFrom.lowercased()), let toLength : Length = Length(rawValue: self.unitConvertedTo.lowercased()) else {
                return
            }
            self.result = convertLengthFromUnitOneToUnitTwo(value: Double(originalUnitValue) ?? 0.0, fromUnit: fromLength, toUnit: toLength)

        }else if (self.currentUnitSelectedTab == 1){
            guard let fromWeight : Weight = Weight(rawValue: self.unitConvertedFrom.lowercased()), let toWeight : Weight = Weight(rawValue: self.unitConvertedTo.lowercased()) else {
                return
            }
            self.result = convertWeightFromUnitOneToUnitTwo(value: Double(originalUnitValue) ?? 0.0, fromUnit: fromWeight, toUnit: toWeight)
        }else if (self.currentUnitSelectedTab == 2){
            guard let fromTemp : Temperature = Temperature(rawValue: self.unitConvertedFrom.lowercased()), let toTemperature : Temperature = Temperature(rawValue: self.unitConvertedTo.lowercased()) else {
                return
            }
            self.result = convertTemperatureFromUnitOneToUnitTwo(Double(originalUnitValue) ?? 0.0, from: fromTemp, to: toTemperature)
        }
    }
    
    
    var body : some View {
        ScrollView {
            VStack(spacing: 20) {
                // Input Value Card
                VStack(alignment: .leading, spacing: 12) {
                    Text(getCategoryLabel())
                        .font(.headline)
                        .foregroundColor(.secondary)

                    TextField("Enter value", text: $originalUnitValue)
                        .keyboardType(.decimalPad)
                        .font(.system(size: 24, weight: .semibold))
                        .padding()
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(12)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)

                // From Unit Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("From")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }

                    Picker("From Unit", selection: $unitConvertedFrom) {
                        if(self.currentUnitSelectedTab == 0) {
                            ForEach(Length.allCases) { unit  in
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }else if (self.currentUnitSelectedTab == 1) {
                            ForEach(Weight.allCases) { unit  in
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }else if (self.currentUnitSelectedTab == 2) {
                            ForEach(Temperature.allCases) { unit  in
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.primary)
                    .padding()
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(12)
                    .onChange(of: currentUnitSelectedTab) { oldValue, newValue in
                        switch newValue {
                        case 0: unitConvertedFrom = "millimeter"
                        case 1: unitConvertedFrom = "milligram"
                        case 2: unitConvertedFrom = "celsius"
                        default: break
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)

                // Swap Icon
                Image(systemName: "arrow.down.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.blue)
                    .opacity(0.6)

                // To Unit Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("To")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }

                    Picker("To Unit", selection: $unitConvertedTo) {
                        if(self.currentUnitSelectedTab == 0) {
                            ForEach(Length.allCases) { unit  in
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }else if (self.currentUnitSelectedTab == 1) {
                            ForEach(Weight.allCases) { unit  in
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }else if (self.currentUnitSelectedTab == 2) {
                            ForEach(Temperature.allCases) { unit  in
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.primary)
                    .padding()
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(12)
                    .onChange(of: currentUnitSelectedTab) { oldValue, newValue in
                        switch newValue {
                        case 0: unitConvertedTo = "millimeter"
                        case 1: unitConvertedTo = "milligram"
                        case 2: unitConvertedTo = "celsius"
                        default: break
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)

                // Convert Button
                Button {
                    self.handleSubmit()
                    self.isSubmited = true
                } label: {
                    Text("Convert")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            originalUnitValue.isEmpty ? Color.gray : Color.blue
                        )
                        .cornerRadius(12)
                }
                .disabled(originalUnitValue.isEmpty)
                .padding(.top, 8)

                Spacer(minLength: 40)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }

    private func getCategoryLabel() -> String {
        switch currentUnitSelectedTab {
        case 0: return "Length Value"
        case 1: return "Weight Value"
        case 2: return "Temperature Value"
        default: return "Value"
        }
    }
}

#Preview {
    ContentView()
    
}
