//
//  AlertContext.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

struct AlertContext {

    // MARK: HealthKit errors
    static let unableToAccessHealthKit = AlertItem(
        title: Text("Access denied"),
        message: Text("Unable to retrieve records from HealthKit.\nPlease give Hey! Hydrate! access to HealthKit."),
        dismissButton: .default(Text("Ok"))
    )

    static let unableToGetHealthRecords = AlertItem(
        title: Text("HealthKit error"),
        message: Text("Unable to retrieve HealthKit records at this time.\nPlease try again."),
        dismissButton: .default(Text("Ok"))
    )

    static let unableToUpdateHealthRecords = AlertItem(
        title: Text("HealthKit error"),
        message: Text("Unable to update HealthKit records at this time.\nPlease try again."),
        dismissButton: .default(Text("Ok"))
    )
}
