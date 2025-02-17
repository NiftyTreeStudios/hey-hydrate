//
//  Utilities.swift
//  Hey! Hydrate!
//
//  Created by Iiro Alhonen on 15.12.21.
//

import Foundation

/**
 Calculates the percentage of water drank from the daily goal.
 
 - Parameter waterDrank: the amount of water drank today.
 - Parameter goal: the water drinking goal.
 
 - Returns: the percentage of water drank from the daily goal.
 */
func calculatePercentageDrank(waterDrank: Int, goal: Int) -> Double {
    return Double(waterDrank) / Double(goal)
}

extension Int {
    /**
     Rounds the `Int` to the closest 10.

     - Returns: `Int` rounded to the closest 10.
     */
    func roundToTens() -> Int {
        let original = Double(self)
        let rounded = (original / 10).rounded() * 10
        return Int(rounded)
    }
}
