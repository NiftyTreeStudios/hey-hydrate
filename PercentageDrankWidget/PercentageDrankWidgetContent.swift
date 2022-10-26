//
//  PercentageDrankWidgetContent.swift
//  Hey! Hydrate!
//
//  Created by Iiro Alhonen on 15.6.2022.
//

import SwiftUI
import WidgetKit

let snapshotEntry = PercentageDrankWidgetContent(
    percentageDrank: 0,
    goal: 1000,
    waterDrank: 0
)

struct PercentageDrankWidgetContent: TimelineEntry, Codable {
    var date = Date()
    let percentageDrank: Double
    let goal: Int
    let waterDrank: Int
}
