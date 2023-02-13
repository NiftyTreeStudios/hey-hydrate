//
//  heyhydrateApp.swift
//  heyhydrate Watch App
//
//  Created by Iiro Alhonen on 10.2.2023.
//

import SwiftUI

@main
struct HeyHydrateWatchApp: App {

    @StateObject private var hkHelper = HealthKitHelper()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(hkHelper)
                .onAppear {
                    hkHelper.setupHealthKit()
                }
        }
    }
}
