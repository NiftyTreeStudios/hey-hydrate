//
//  FluidUnits.swift
//  Hey-Hydrate-iOS
//
//  Created by Iiro Alhonen on 17.01.22.
//

import SwiftUI
import HealthKit

/// Volumetric units found in HKUnit.
enum FluidUnit: String, Codable, CaseIterable {
    case liters, fluidOunceUS, fluidOunceImperial, cupUS, cupImperial, pintUS, pintImperial
}

/// Return a HKUnit equilevant for FluidUnit.
func getHKUnitFor(_ unit: FluidUnit) -> HKUnit {
    switch unit {
    case .liters:
        return HKUnit.liter()
    case .fluidOunceUS:
        return HKUnit.fluidOunceUS()
    case .fluidOunceImperial:
        return HKUnit.fluidOunceImperial()
    case .cupUS:
        return HKUnit.cupUS()
    case .cupImperial:
        return HKUnit.cupImperial()
    case .pintUS:
        return HKUnit.pintUS()
    case .pintImperial:
        return HKUnit.pintImperial()
    }
}

/// Convert values between HKUnits.
func convertValue(from: HKQuantity, to: FluidUnit) -> Double {
    print("Old value: \(from)")
    let value = from.doubleValue(for: getHKUnitFor(to))
    let new = HKQuantity(unit: getHKUnitFor(to), doubleValue: value)
    print("New value: \(new)")
    return new.doubleValue(for: getHKUnitFor(to))
}
