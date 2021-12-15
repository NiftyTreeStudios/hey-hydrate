//
//  AddWaterDrankView.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

struct AddWaterDrankView: View {
    @Binding var percentageDrank: Int
    @Binding var waterDrank: Int
    @Binding var goal: Int
    @State private var cupSize: Int = 200
    @State private var pickCupSheetShown: Bool = false
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
                    self.pickCupSheetShown = true
                } label: {
                    Text("\(cupSize)")
                        .font(.title)
                }
                Button {
                    cupSize += 50
                } label: {
                    Image(systemName: "plus")
                }
            }
            Button {
                waterDrank += cupSize
                percentageDrank = calculatePercentageDrank(waterDrank: waterDrank, goal: goal)
            } label: {
                Text("Add water")
                    .foregroundColor(.white)
                    .padding()
            }.background(Capsule().foregroundColor(.blue))
        }.sheet(isPresented: $pickCupSheetShown) {
            CupSizeSheet(cupSize: $cupSize, isPresented: $pickCupSheetShown)
        }
    }
}

struct AddWaterDrankView_Previews: PreviewProvider {
    static var previews: some View {
        AddWaterDrankView(percentageDrank: .constant(30), waterDrank: .constant(500), goal: .constant(2000))
    }
}
