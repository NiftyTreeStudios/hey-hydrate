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
func calculatePercentageDrank(waterDrank: Double, goal: Double) -> Double {
    return waterDrank / goal
}
