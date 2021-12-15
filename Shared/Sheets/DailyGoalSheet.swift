//
//  DailyGoalSheet.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

struct DailyGoalSheet: View {

    @Binding var goal: Int
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            VStack {
                Spacer()
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
                    Text("Your daily goal: \(goal)")
                    Picker("\(goal)", selection: $goal) {
                        ForEach(0 ..< 5001) { size in
                            if (size % 250) == 0 {
                                Text("\(size)")
                            }
                        }
                    }.pickerStyle(.inline)
                }
            }
        }.background(.clear)
    }
}

struct DailyGoalSheet_Previews: PreviewProvider {
    static var previews: some View {
        DailyGoalSheet(goal: .constant(4500), isPresented: .constant(true))
    }
}
