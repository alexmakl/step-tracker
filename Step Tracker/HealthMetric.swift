//
//  HealthMetric.swift
//  Step Tracker
//
//  Created by Alexander on 24.03.2025.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
