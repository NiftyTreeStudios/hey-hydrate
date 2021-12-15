//
//  HealthKitHelper.swift
//  Hey! Hydrate!
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI
import HealthKit

final class HealthKitHelper: ObservableObject {

    @Published var waterAmount: Int = 0

    let healthStore = HKHealthStore()

    /// Function used to authorize the usage of HealthKit.
    func autorizeHealthKit() {
        let healthStore = HKHealthStore()
        // Used to define the identifiers that create quantity type objects.
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!]
        // Requests permission to save and read the specified data types.
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { ( success, error ) in
            if error != nil {
                print(error)
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

    func getWater(completion: @escaping (Int) -> Void) {
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
                print(error)
            }
            result!.enumerateStatistics(from: startOfDay, to: now) { statistics, _ in
                if let sum = statistics.sumQuantity() {
                    print("Statistics sumquantity: \(sum)")
                    resultCount = sum.doubleValue(for: HKUnit.liter())
                    print("Result count: \(resultCount)")
                }
                DispatchQueue.main.async {
                    completion(Int(resultCount * 1000))
                }
            }
        }

        query.statisticsUpdateHandler = { _, statistics, _, error in
            if error != nil {
                print(error)
            }
            if let sum = statistics?.sumQuantity() {
                let resultCount = sum.doubleValue(for: HKUnit.liter())
                DispatchQueue.main.async {
                    completion(Int(resultCount * 1000))
                }
            }
        }

        healthStore.execute(query)
    }

    func updateWaterAmount(waterAmount: Int) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let waterQuantityType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        let waterAmountToSave = HKQuantitySample(
            type: waterQuantityType,
            quantity: HKQuantity(unit: .liter(), doubleValue: Double(waterAmount) / 1000),
            start: startOfDay,
            end: now
        )
        print("Water amount: \(waterAmount)")
        print("Water amount to save: \(waterAmountToSave)")
        healthStore.save(waterAmountToSave) { success, error in
            if error != nil {
                print(error)
            }
            if success {
                print("Update worked!")
            }
        }
    }
}
