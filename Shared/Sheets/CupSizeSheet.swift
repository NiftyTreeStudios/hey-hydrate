//
//  CupSizeSheet.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

struct CupSizeSheet: View {

    @Binding var cupSize: Int
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    ZStack {
                        Capsule().frame(width: 75, height: 5, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                        HStack {
                            Spacer()
                            Button {
                                self.isPresented = false
                            } label: {
                                Text("Done")
                            }.padding()
                        }
                    }
                    Picker("\(cupSize)", selection: $cupSize) {
                        ForEach(0 ..< 5001) { size in
                            if size <= 500 && (size % 10) == 0 {
                                Text("\(size)")
                            } else if size <= 1000 && (size % 50) == 0 {
                                Text("\(size)")
                            } else if size <= 2500 && (size % 100) == 0 {
                                Text("\(size)")
                            } else if (size % 250) == 0 {
                                Text("\(size)")
                            }
                        }
                    }.pickerStyle(.inline)
                }
            }
        }.background(.clear)
    }
}

struct CupSizeSheet_Previews: PreviewProvider {
    static var previews: some View {
        CupSizeSheet(cupSize: .constant(500), isPresented: .constant(true))
    }
}
