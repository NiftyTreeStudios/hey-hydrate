//
//  DoubleExtension.swift
//  Hey-Hydrate-iOS
//
//  Created by Iiro Alhonen on 18.01.22.
//

import Foundation

extension Double {
    
    /// Convert liters to ml.
    func literToMl() -> Double {
        return self * 1000
    }
    
    /// Convert ml to liters.
    func mlToLiter() -> Double {
        return self / 1000
    }
}
