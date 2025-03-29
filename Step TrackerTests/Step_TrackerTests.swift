//
//  Step_TrackerTests.swift
//  Step TrackerTests
//
//  Created by Alexander on 29.03.2025.
//

import Foundation
import Testing
@testable import Step_Tracker

struct Step_TrackerTests {

    @Test func dateValueAverage() {
        let array: [Double] = [10.30, 4.54, 7.24, 9.14]
        #expect(array.average == 7.805)
    }
}

@Suite("Chart Helper Tests")
struct ChartHelperTests {
    
    var metrics: [HealthMetric] = [
        .init(date: Calendar.current.date(from: .init(year: 2025, month: 03, day: 24))!, value: 2000),  // Monday
        .init(date: Calendar.current.date(from: .init(year: 2025, month: 03, day: 25))!, value: 550),   // Tuesday
        .init(date: Calendar.current.date(from: .init(year: 2025, month: 03, day: 26))!, value: 650),   // Wednesday
        .init(date: Calendar.current.date(from: .init(year: 2025, month: 03, day: 31))!, value: 500)    // Monday
    ]

    @Test func averageWeekdayCount() {
        let averageWeekdayCount = ChartHelper.averageWeekdayCount(for: metrics)
        #expect(averageWeekdayCount.count == 3)
        #expect(averageWeekdayCount[0].value == 1250)
        #expect(averageWeekdayCount[1].value == 550)
        #expect(averageWeekdayCount[2].date.weekdayTitle == "Wednesday")
    }
}
