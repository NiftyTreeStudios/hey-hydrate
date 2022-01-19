//
//  DailyGoalSheet.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI
import HealthKit

struct SettingsView: View {

    @Binding var goal: Double
    @State private var goalPicker: Int

    @EnvironmentObject var hkHelper: HealthKitHelper
    @State private var unitUsed: FluidUnit = .liters

    @State private var cupSizeString: String = ""
    @FocusState private var cupSizeTextFieldFocused: Bool
    @Binding var cupSize: Int

    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            ZStack {
                Capsule().frame(width: 75, height: 5, alignment: .center)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                HStack {
                    Spacer()
                    Button {
                        self.isPresented = false
                        hkHelper.setupHealthKit()
                    } label: {
                        Text("Done")
                    }.padding()
                }
            }
            List {

                Text("Fluid units used:")
                Picker("\(hkHelper.unitsUsed.rawValue)", selection: hkHelper.$unitsUsed) {
                    ForEach(FluidUnit.allCases, id: \.self) { size in
                        switch size {
                        case .liters:
                            Text("Liters")
                        case .fluidOunceUS:
                            Text("Fluid ounce, US")
                        case .fluidOunceImperial:
                            Text("Fluid ounce, imperial")
                        case .cupUS:
                            Text("Cups, US")
                        case .cupImperial:
                            Text("Cups, imperial")
                        case .pintUS:
                            Text("Pint, US")
                        case .pintImperial:
                            Text("Pint, imperial")
                        }
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: hkHelper.unitsUsed) { [unitUsed] newUnit in
                    print("Values: \(unitUsed), new: \(newUnit)")
                    hkHelper.setupHealthKit()
                    convertValue(
                        from: HKQuantity(
                            unit: getHKUnitFor(unitUsed),
                            doubleValue: Double(hkHelper.waterAmount)),
                        to: hkHelper.unitsUsed
                    )
                    self.unitUsed = newUnit
                }

                Text("Your daily goal: \(goal)")
                Picker("\(goal)", selection: $goalPicker) {
                    ForEach(0 ..< 5001) { size in
                        if (size % 250) == 0 {
                            Text("\(size)")
                        }
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: goalPicker) { newValue in
                    goal = Double(goalPicker)
                }

                Text("Enter cup size:")
                HStack {
                    TextField(
                        "Cup size",
                        text: $cupSizeString,
                        prompt: Text("\(cupSize)")
                    )
                        .keyboardType(.numberPad)
                        .focused($cupSizeTextFieldFocused)

                    Button {
                        cupSizeTextFieldFocused = false
                        if let convertedCupSizeString = Int(cupSizeString) {
                            cupSize = convertedCupSizeString
                        } else {
                            print("Failed to convert the inputted cup size to a number.")
                        }
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
        .onAppear {
            unitUsed = hkHelper.unitsUsed
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            goal: .constant(4500),
            goalPicker: .constant(4000),
            cupSize: .constant(500),
            isPresented: .constant(true)
        )
    }
}
