//
//  ContentView.swift
//  Shared
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI
import HealthKit

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()
    @EnvironmentObject var hkHelper: HealthKitHelper

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    self.viewModel.showPopover = true
                } label: {
                    Image(systemName: "flag")
                }
                .padding()
                .sheet(
                    isPresented: $viewModel.showPopover,
                    onDismiss: {
                        viewModel.percentageDrank = calculatePercentageDrank(
                            waterDrank: hkHelper.waterAmount,
                            goal: viewModel.goal
                        )
                    }) { // swiftlint:disable:this multiple_closures_with_trailing_closure
                    DailyGoalSheet(goal: $viewModel.goal, isPresented: $viewModel.showPopover)
                }

            }
            Spacer()
            // The water drank indicator
            WaterDrankIdicatorView(
                percentageDrank: $viewModel.percentageDrank,
                goal: $viewModel.goal,
                waterDrank: $hkHelper.waterAmount
            )
            Spacer()
            // Add more water drank
            AddWaterDrankView(
                percentageDrank: $viewModel.percentageDrank,
                waterDrank: $hkHelper.waterAmount,
                goal: $viewModel.goal
            )
            Spacer()
        }
        .onAppear {
            hkHelper.autorizeHealthKit()
            viewModel.percentageDrank = calculatePercentageDrank(waterDrank: hkHelper.waterAmount, goal: viewModel.goal)
        }
        .alert(item: $hkHelper.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}