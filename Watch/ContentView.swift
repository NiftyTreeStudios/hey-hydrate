//
//  ContentView.swift
//  heyhydrate Watch App
//
//  Created by Iiro Alhonen on 10.2.2023.
//

import HealthKit
import SwiftUI

struct ContentView: View {
    @State private var progress: Double = 0
    @State private var goal: Int = 3000
    @State private var waterAmount: Int = 250
    @State private var waterTotal: Int = 0
    @State private var units: UnitType = .ml

    @EnvironmentObject var hkHelper: HealthKitHelper

    @State private var crownRotation = 0.1
    
    var body: some View {
        VStack(spacing: 8) {
            WaterIndicatorView(progress: progress, waterTotal: $waterTotal)
            Spacer()
            Button(action: {
                hkHelper.getWater { (result) in
                    DispatchQueue.main.async {
                        self.waterTotal = result
                    }
                }
                waterTotal += waterAmount
                if progress < 1 {
                    progress = Double(waterTotal) / Double(goal)
                } else {
                    progress = 1
                }
                hkHelper.updateWaterAmount(waterAmount: waterAmount)
            }, label: {
                Text("Drink \(waterAmount) \(units.rawValue)")
            })
        }
        .padding()
        .focusable(true)
        .digitalCrownRotation(
            detent: $crownRotation,
            from: .infinity,
            through: .infinity,
            by: 1,
            sensitivity: .low,
            isContinuous: true,
            isHapticFeedbackEnabled: true
        ) { crownEvent in
            if 0 < crownEvent.velocity {
                waterAmount += 10
            } else if 0 > crownEvent.velocity {
                if waterAmount > 20 {
                    waterAmount -= 10
                } else {
                    waterAmount = 10
                }
            }
        }
        .onAppear {
            hkHelper.getWater { (result) in
                DispatchQueue.main.async {
                    waterTotal = result
                    if progress < 1 {
                        progress = Double(waterTotal) / Double(goal)
                    } else {
                        progress = 1
                    }
                }
            }
        }
    }
}

struct WaterIndicatorView: View {
    let progress: Double
    @Binding var waterTotal: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(.blue.opacity(0.3), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.blue, lineWidth: 10)
                .rotationEffect(.degrees(90))
            Text("\(waterTotal)")
        }
        .animation(.easeInOut, value: progress)
    }
}

enum UnitType: String {
    case oz, ml
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
