//
//  DailyGoalSheet.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

struct SettingsView: View {

    @State private var cupSizeString: String = ""
    @FocusState private var cupSizeTextFieldFocused: Bool
    @Binding var goal: Int
    @Binding var cupSize: Int
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("Your daily goal: \(goal)")
                    Picker("\(goal)", selection: $goal) {
                        ForEach(0 ..< 5001) { size in
                            if (size % 250) == 0 {
                                Text("\(size)")
                            }
                        }
                    }.pickerStyle(.wheel)
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
                            print(cupSizeString)
                            if let convertedCupSizeString = Int(cupSizeString) {
                                cupSize = convertedCupSizeString
                            } else {
                                print("Failed to convert the inputted cup size to a number.")
                            }
                        } label: {
                            Text("Done")
                        }.disabled(cupSizeString.isEmpty)
                    }
                }
                //.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Settings")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(goal: .constant(4500), cupSize: .constant(500), isPresented: .constant(true))
    }
}
