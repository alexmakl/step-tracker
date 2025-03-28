//
//  ChartHelper.swift
//  Step Tracker
//
//  Created by Alexander on 28.03.2025.
//

import Foundation

struct ChartHelper {
    static func convert(data: [HealthMetric]) -> [DateValueChartData] {
        data.map { DateValueChartData(date: $0.date, value: $0.value)}
    }
    
    static func parseSelectedDate(from data: [DateValueChartData], in selectedDate: Date?) -> DateValueChartData? {
        guard let selectedDate else { return nil }
        return data.first {
            Calendar.current.isDate(selectedDate, inSameDayAs: $0.date)
        }
    }
}
