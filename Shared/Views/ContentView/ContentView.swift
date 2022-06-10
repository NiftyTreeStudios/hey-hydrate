//
//  ContentView.swift
//  Shared
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var hkHelper: HealthKitHelper
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        //NavigationView {
        ZStack {
            HydrationView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Hey! Hydrate!")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            hkHelper.setupHealthKit()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            Button {
                hkHelper.setupHealthKit()
            } label: {
                Image(systemName: "arrow.clockwise")
            }.position(x: 30, y: 30)
        }
        //}
        .onChange(of: scenePhase, perform: { _ in
            hkHelper.setupHealthKit()
        })
        .alert(item: $hkHelper.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
    }
}

struct HydrationView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @EnvironmentObject var hkHelper: HealthKitHelper

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 150) {
                // The water drank indicator
                WaterDrankIndicatorView(
                    percentageDrank: $viewModel.percentageDrank,
                    goal: $viewModel.goal,
                    waterDrank: $hkHelper.waterAmount
                )
                // Add more water drank
                AddWaterDrankView(
                    percentageDrank: $viewModel.percentageDrank,
                    waterDrank: $hkHelper.waterAmount,
                    goal: $viewModel.goal,
                    cupSize: $viewModel.cupSize
                )
            }.position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 50)
        }
        .onChange(of: hkHelper.waterAmount, perform: { _ in
            viewModel.percentageDrank = calculatePercentageDrank(waterDrank: hkHelper.waterAmount, goal: viewModel.goal)
        })
    }
}
