//
//  ContentView.swift
//  Shared
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

struct ContentView: View {
    @State private var percentageDrank: Int = 0
    @State private var waterDrank: Int = 0
    @State private var goal: Int = 2000
    @State private var showPopover: Bool = false
    var body: some View {
        VStack {
            HStack {
                Button {
                    waterDrank = 0
                    percentageDrank = 0
                } label: {
                    Text("Reset")
                }.padding()
//test swiftlint warning on xcode cloud run
                Spacer()
                Button {
                    self.showPopover = true
                } label: {
                    Image(systemName: "flag")
                }
                .padding()
                .sheet(isPresented: $showPopover, onDismiss: {
                    percentageDrank = calculatePercentageDrank(waterDrank: waterDrank, goal: goal)
                }) { // swiftlint:disable:this multiple_closures_with_trailing_closure
                    GoalPopover(goal: $goal)
                }

            }
            Spacer()
            // The water drank indicator
            WaterDrankIdicatorView(percentageDrank: $percentageDrank, waterDrank: $waterDrank)
            Spacer()
            // Add more water drank
            AddWaterDrankView(percentageDrank: $percentageDrank, waterDrank: $waterDrank, goal: $goal)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
