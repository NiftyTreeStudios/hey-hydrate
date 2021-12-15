//
//  GoalPopover.swift
//  Hey! Hydrate!
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

struct GoalPopover: View {
    @Binding var goal: Int
    var body: some View {
        VStack {
            Text("Your water drinking goal:")
            Stepper(
                "Goal",
                onIncrement: {
                    goal += 100
                }, onDecrement: {
                    goal -= 100
                }
            ).labelsHidden()
            Text("Goal: \(goal) ml")
        }
    }
}

struct GoalPopover_Previews: PreviewProvider {
    static var previews: some View {
        GoalPopover(goal: .constant(1500))
    }
}
