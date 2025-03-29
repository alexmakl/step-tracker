//
//  ChartDataTypes.swift
//  Step Tracker
//
//  Created by Alexander on 25.03.2025.
//

import Foundation

struct DateValueChartData: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let value: Double
}
