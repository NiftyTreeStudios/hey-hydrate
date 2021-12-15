//
//  ContentView.swift
//  Shared
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var percentageDrank: Double = 0
    @State private var waterDrank: Int = 0
    @State private var goal: Int = 2000
    @State private var showPopover: Bool = false

    @StateObject private var hkHelper = HealthKitHelper()

    var body: some View {
        VStack {
            HStack {
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
                    DailyGoalSheet(goal: $goal, isPresented: $showPopover)
                }

            }
            Spacer()
            // The water drank indicator
            WaterDrankIdicatorView(percentageDrank: $percentageDrank, waterDrank: $hkHelper.waterAmount)
            Spacer()
            // Add more water drank
            AddWaterDrankView(
                percentageDrank: $percentageDrank,
                waterDrank: $hkHelper.waterAmount,
                goal: $goal,
                hkHelper: hkHelper
            )
            Spacer()
        }
        .onAppear {
            hkHelper.autorizeHealthKit()
            percentageDrank = calculatePercentageDrank(waterDrank: waterDrank, goal: goal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
