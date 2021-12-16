//
//  DailyGoalSheet.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

struct SettingsView: View {

    @Binding var goal: Int
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
                    } label: {
                        Text("Done")
                    }.padding()
                }
            }
            List {
                Text("Your daily goal: \(goal)")
                Picker("\(goal)", selection: $goal) {
                    ForEach(0 ..< 5001) { size in
                        if (size % 250) == 0 {
                            Text("\(size)")
                        }
                    }
                }.pickerStyle(.wheel)
                Text("Cup size: \(cupSize)")
                Picker("\(cupSize)", selection: $cupSize) {
                    ForEach(0 ..< 5001) { size in
                        if size <= 500 && (size % 10) == 0 {
                            Text("\(size)")
                        } else if size <= 1000 && (size % 50) == 0 {
                            Text("\(size)")
                        } else if size <= 2500 && (size % 100) == 0 {
                            Text("\(size)")
                        } else if (size % 250) == 0 {
                            Text("\(size)")
                        }
                    }
                }.pickerStyle(.wheel)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(goal: .constant(4500), cupSize: .constant(500), isPresented: .constant(true))
    }
}
