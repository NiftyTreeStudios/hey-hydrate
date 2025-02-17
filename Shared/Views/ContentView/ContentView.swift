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

    @State private var addWaterAlertIsPresented = false
    @State private var customWaterAmount: String = ""
    @State private var customDate: Date = Date()

    var body: some View {
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
            VStack {
                HStack {
                    Button {
                        hkHelper.setupHealthKit()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    Spacer()
                    Button {
                        addWaterAlertIsPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                Spacer()
            }.padding(30)
        }
        .onChange(of: scenePhase, { _, _ in
            hkHelper.setupHealthKit()
        })
        .alert(item: $hkHelper.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .sheet(isPresented: $addWaterAlertIsPresented) {
            ScrollView {
                Text("Add previously drunk water")
                    .font(.headline)
                HStack {
                    Text("Water amount (ml)")
                    Spacer()
                    TextField("200", text: $customWaterAmount)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }.padding(10)
                DatePicker("For date", selection: $customDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                Button("Add water") {
                    hkHelper.updateWaterAmount(waterAmount: Int(customWaterAmount) ?? 0, for: customDate)
                    hkHelper.setupHealthKit()
                    addWaterAlertIsPresented = false
                }
            }
            .padding()
            .presentationDetents([.fraction(0.75)])
        }
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
        .onChange(of: hkHelper.waterAmount, { _, _ in
            viewModel.percentageDrank = calculatePercentageDrank(waterDrank: hkHelper.waterAmount, goal: viewModel.goal)
        })
    }
}
