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
func calculatePercentageDrank(waterDrank: Int, goal: Int) -> Int {
    return Int(Double(waterDrank) / Double(goal) * Double(100))
}
