//
//  AddWaterDrankView.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

struct AddWaterDrankView: View {
    @Binding var percentageDrank: Int
    var body: some View {
        Button {
            percentageDrank += 10
            print(percentageDrank)
        } label: {
            Text("Add water")
        }

    }
}

struct AddWaterDrankView_Previews: PreviewProvider {
    static var previews: some View {
        AddWaterDrankView(percentageDrank: .constant(30))
    }
}
