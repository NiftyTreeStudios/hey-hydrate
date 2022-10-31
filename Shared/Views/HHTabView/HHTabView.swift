//
//  HHTabView.swift
//  Hey-Hydrate-iOS
//
//  Created by Iiro Alhonen on 10.6.2022.
//

import SwiftUI

struct HHTabView: View {
    @StateObject var viewModel = ContentViewModel()
    @EnvironmentObject var hkHelper: HealthKitHelper

    var body: some View {
        TabView {
            ContentView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "drop")
                    Text("Home")
                }.tag("Home")
            SettingsView(
                goal: $viewModel.goal,
                cupSize: $viewModel.cupSize,
                isPresented: $viewModel.showPopover
            )
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }.tag("Settings")
        }
    }
}

struct HHTabView_Previews: PreviewProvider {
    static var previews: some View {
        HHTabView()
    }
}
