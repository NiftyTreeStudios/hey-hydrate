//
//  WaterDrankIdicatorView.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 14.12.21.
//

import SwiftUI

struct WaterDrankIdicatorView: View {
    @Binding var percentageDrank: Int
    @Binding var waterDrank: Int
    var body: some View {
        ZStack {
            Text("\(waterDrank)")
                .font(.title)
        }.background(WaterDrankBackground(percentageDrank: $percentageDrank))
    }
}

struct WaterDrankBackground: View {
    @Binding var percentageDrank: Int
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)

    var customBlue: Color = Color(red: 0, green: 0.5, blue: 0.9, opacity: 1)
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 220, height: 220, alignment: .center)
                .foregroundColor(customBlue)
                .opacity(0.75)
            Circle()
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(Color(UIColor.systemBackground))
            ZStack {
                Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percentageDrank)/100)
                    .fill(customBlue)
                    .opacity(0.5)
                    .frame(width: 200, height: 210)
                    .offset(y: -5)
                Wave(offset: Angle(degrees: self.waveOffset2.degrees), percent: Double(percentageDrank)/100)
                    .fill(customBlue)
                    .opacity(0.5)
                    .frame(width: 200, height: 210)
                    .offset(x: 5)
            }
            .mask(Circle().frame(width: 190, height: 190, alignment: .center))
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
                self.waveOffset2 = Angle(degrees: -180)
            }
        }
    }
}

struct Wave: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight = 0.017 * rect.height
        let yOffset = CGFloat(1 - percent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        path.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offset.radians))))

        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let xPos = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            path.addLine(to: CGPoint(x: xPos, y: yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }

    var offset: Angle
    var percent: Double

    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
}

struct WaterDrankIdicatorView_Previews: PreviewProvider {
    static var previews: some View {
        WaterDrankIdicatorView(percentageDrank: .constant(30), waterDrank: .constant(500))
    }
}
