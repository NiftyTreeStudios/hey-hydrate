//
//  WaterDrankIdicatorView.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

struct WaterDrankIdicatorView: View {
    @Binding var percentageDrank: Int
    var body: some View {
        ZStack {
            Text("Water drank!")
        }.background(WaterDrankBackground(percentageDrank: $percentageDrank))
    }
}

struct WaterDrankBackground: View {
    @Binding var percentageDrank: Int
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(.blue)
            Circle()
                .frame(width: 190, height: 190, alignment: .center)
                .foregroundColor(.white)
            Rectangle()
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(.blue)
                .offset(x: 0, y: 200 - CGFloat(percentageDrank * 2))
        }
    }
}

struct WaterDrankIdicatorView_Previews: PreviewProvider {
    static var previews: some View {
        WaterDrankIdicatorView(percentageDrank: .constant(30))
    }
}
