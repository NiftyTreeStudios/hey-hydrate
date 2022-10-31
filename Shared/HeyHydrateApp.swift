//
//  Hey__Hydrate_App.swift
//  Shared
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

@main
struct HeyHydrateApp: App {

    @StateObject private var hkHelper = HealthKitHelper()

    var body: some Scene {
        WindowGroup {
            HHTabView().environmentObject(hkHelper)
        }
    }
}
