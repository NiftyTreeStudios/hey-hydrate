//
//  AlertItem.swift
//  Hey! Hydrate! (iOS)
//
//  Created by Iiro Alhonen on 15.12.21.
//

import SwiftUI

struct AlertItem: Identifiable {

    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button

}
