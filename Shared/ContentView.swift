//
//  ContentView.swift
//  Shared
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

struct ContentView: View {
    @State private var percentageDrank: Int = 0
    var body: some View {
        VStack {
            Spacer()
            /// The water drank indicator
            WaterDrankIdicatorView(percentageDrank: $percentageDrank)
            Spacer()
            /// Add more water drank
            AddWaterDrankView(percentageDrank: $percentageDrank)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
