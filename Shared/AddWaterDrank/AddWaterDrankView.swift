//
//  AddWaterDrankView.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

struct AddWaterDrankView: View {
    @Binding var percentageDrank: Double
    @Binding var waterDrank: Int
    @Binding var goal: Int
    @Binding var cupSize: Int

    @EnvironmentObject var hkHelper: HealthKitHelper

    var body: some View {
        VStack {
            HStack {
                Button {
                    if cupSize <= 0 {
                        cupSize = 0
                    } else {
                        cupSize -= 50
                    }
                } label: {
                    Image(systemName: "minus")
                }
                Button {
                    waterDrank += cupSize
                    percentageDrank = calculatePercentageDrank(waterDrank: waterDrank, goal: goal)
                    hkHelper.updateWaterAmount(waterAmount: cupSize)
                } label: {
                    Text("Add \(cupSize) ml")
                        .foregroundColor(.white)
                        .padding()
                }.background(Capsule().foregroundColor(.blue))
                Button {
                    cupSize += 50
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct AddWaterDrankView_Previews: PreviewProvider {
    static var previews: some View {
        AddWaterDrankView(
            percentageDrank: .constant(30),
            waterDrank: .constant(500),
            goal: .constant(2000),
            cupSize: .constant(500)
        )
    }
}
