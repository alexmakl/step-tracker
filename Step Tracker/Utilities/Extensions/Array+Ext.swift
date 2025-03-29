//
//  Array+Ext.swift
//  Step Tracker
//
//  Created by Alexander on 28.03.2025.
//

import Foundation

extension Array where Element == Double {
    var average: Double {
        guard !self.isEmpty else { return 0 }
        let totalStepsCount = self.reduce(0, +)
        return totalStepsCount / Double(self.count)
    }
}
