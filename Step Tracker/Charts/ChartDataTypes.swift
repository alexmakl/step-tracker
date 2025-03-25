//
//  ChartDataTypes.swift
//  Step Tracker
//
//  Created by Alexander on 25.03.2025.
//

import Foundation

struct WeekdayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
