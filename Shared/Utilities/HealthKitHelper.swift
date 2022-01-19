//
//  HealthKitHelper.swift
//  Hey! Hydrate!
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI
import HealthKit

final class HealthKitHelper: ObservableObject {

    @AppStorage("previousAppUse") var previousAppUse: Double = 0
    @AppStorage("unitsUsed") var unitsUsed: FluidUnit = .liters

    @Published var waterAmount: Double = 0
    @Published var alertItem: AlertItem?

    let healthStore = HKHealthStore()

    func setupHealthKit() {
        let authorizationStatus = healthStore.authorizationStatus(
            for: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!
        )
        switch authorizationStatus {
        case .notDetermined:
            authorizeHealthKit()
        case .sharingDenied:
            self.alertItem = AlertContext.unableToAccessHealthKit
        case .sharingAuthorized:
            self.getWater { (result) in
                DispatchQueue.main.async {
                    self.waterAmount = result
                    self.resetValuesIfLoginWasInPast()
                }
            }
        @unknown default:
            self.alertItem = AlertContext.unableToUpdateHealthRecords
        }
    }

    func resetValuesIfLoginWasInPast() {
        let previousUse = Date(timeIntervalSinceReferenceDate: previousAppUse)
        if !Calendar.current.isDateInToday(previousUse) {
            waterAmount = 0
        }
        previousAppUse = Date().timeIntervalSinceReferenceDate
    }

    // MARK: Initial authorizations
    /// Function used to authorize the usage of HealthKit.
    func authorizeHealthKit() {
        let healthStore = HKHealthStore()
        // Used to define the identifiers that create quantity type objects.
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!]
        // Requests permission to save and read the specified data types.
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { ( success, error ) in
            if error != nil {
                self.alertItem = AlertContext.unableToAccessHealthKit
            }
            if success {
                // Query water consumed
                self.getWater { (result) in
                    DispatchQueue.main.async {
                        self.waterAmount = result
                    }
                }
            }
        }
    }

    func getWater(completion: @escaping (Double) -> Void) {
        let waterQuantityType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        var interval = DateComponents()
        interval.day = 1

        let query = HKStatisticsCollectionQuery(
            quantityType: waterQuantityType,
            quantitySamplePredicate: nil,
            options: [.cumulativeSum],
            anchorDate: startOfDay,
            intervalComponents: interval
        )

        query.initialResultsHandler = { _, result, error in
            var resultCount = 0.0
            if error != nil {
                self.alertItem = AlertContext.unableToGetHealthRecords
            }
            result!.enumerateStatistics(from: startOfDay, to: now) { statistics, _ in
                if let sum = statistics.sumQuantity() {
                    resultCount = sum.doubleValue(for: getHKUnitFor(self.unitsUsed))
                }
                DispatchQueue.main.async {
                    completion(resultCount)
                }
            }
        }

        query.statisticsUpdateHandler = { _, statistics, _, error in
            if error != nil {
                self.alertItem = AlertContext.unableToGetHealthRecords
            }
            if let sum = statistics?.sumQuantity() {
                let resultCount = sum.doubleValue(for: getHKUnitFor(self.unitsUsed))
                DispatchQueue.main.async {
                    completion(resultCount)
                }
            }
        }

        healthStore.execute(query)
    }

    func updateWaterAmount(waterAmount: Double) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let waterQuantityType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        let waterAmountToSave = HKQuantitySample(
            type: waterQuantityType,
            quantity: HKQuantity(
                unit: getHKUnitFor(self.unitsUsed),
                doubleValue: waterAmount
            ),
            start: startOfDay,
            end: now
        )
        healthStore.save(waterAmountToSave) { success, error in
            if error != nil {
                self.setupHealthKit()
            }
            if success {
                print("Update worked!")
            }
        }
    }
}
