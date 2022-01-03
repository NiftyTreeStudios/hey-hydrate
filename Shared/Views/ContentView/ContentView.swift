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
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack {
            HStack {
                Button {
                    hkHelper.setupHealthKit()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }.padding()

                Spacer()

                Button {
                    self.viewModel.showPopover = true
                } label: {
                    Image(systemName: "gear")
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
                        SettingsView(
                            goal: $viewModel.goal,
                            cupSize: $viewModel.cupSize,
                            isPresented: $viewModel.showPopover
                        )
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
                goal: $viewModel.goal,
                cupSize: $viewModel.cupSize
            )
            Spacer()
        }
        .onChange(of: hkHelper.waterAmount, perform: { _ in
            viewModel.percentageDrank = calculatePercentageDrank(waterDrank: hkHelper.waterAmount, goal: viewModel.goal)
        })
        .onChange(of: scenePhase, perform: { _ in
            hkHelper.setupHealthKit()
        })
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
