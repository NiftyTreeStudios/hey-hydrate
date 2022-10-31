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
                    Picker("Daily goal:", selection: $goal) {
                        ForEach(0 ..< 5001) { size in
                            if (size % 250) == 0 {
                                Text("\(size)")
                            }
                        }
                    }.pickerStyle(.menu)
                    Picker("Cup size:", selection: $cupSize) {
                        ForEach(0 ..< 5001) { size in
                            if (size % 50) == 0 {
                                Text("\(size)")
                            }
                        }
                    }.pickerStyle(.menu)
                }
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
