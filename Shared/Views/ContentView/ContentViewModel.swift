//
//  ContentViewModel.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @AppStorage("goal") var goal: Int = 2000
    @AppStorage("cupSize") var cupSize: Int = 200
    @Published var percentageDrank: Double = 0
    @Published var showPopover: Bool = false
}
