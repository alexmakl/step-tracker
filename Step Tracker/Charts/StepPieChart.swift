//
//  StepPieChart.swift
//  Step Tracker
//
//  Created by Alexander on 25.03.2025.
//

import Charts
import SwiftUI

struct StepPieChart: View {
    
    @State private var rawSelectedValue: Double? = 0
    @State private var selectedDay: Date?
    
    var chartData: [DateValueChartData]
    
    var selectedWeekday: DateValueChartData? {
        guard let rawSelectedValue else { return nil }
        var total = 0.0
        return chartData.first {
            total += $0.value
            return rawSelectedValue <= total
        }
    }
    
    var body: some View {
        let config = ChartContainerConfiguration(title: "Averages",
                                                 symbol: "calendar",
                                                 subtitle: "Last 28 days",
                                                 context: .steps,
                                                 isNav: false)
        ChartContainer(config: config) {
            if chartData.isEmpty {
                ChartEmptyView(systemImageName: "chart.pie", title: "No Data", description: "There is no step data from Health App")
            } else {
                Chart {
                    ForEach(chartData) { weekday in
                        SectorMark(angle: .value("Average Steps", weekday.value),
                                   innerRadius: .ratio(0.62),
                                   outerRadius: selectedWeekday?.date.weekdayInt == weekday.date.weekdayInt ? .ratio(1) : .ratio(0.95),
                                   angularInset: 1)
                        .foregroundStyle(.pink)
                        .cornerRadius(6)
                        .opacity(selectedWeekday?.date.weekdayInt == weekday.date.weekdayInt ? 1.0 : 0.3)
                    }
                }
                .chartAngleSelection(value: $rawSelectedValue.animation(.easeInOut))
                .frame(height: 240)
                .chartBackground { proxy in
                    GeometryReader { geo in
                        if let plotFrame = proxy.plotFrame {
                            let frame = geo[plotFrame]
                            if let selectedWeekday {
                                VStack {
                                    Text(selectedWeekday.date.weekdayTitle)
                                        .font(.title3.bold())
                                        .contentTransition(.identity)
                                    
                                    Text(selectedWeekday.value, format: .number.precision(.fractionLength(0)))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.secondary)
                                        .contentTransition(.numericText())
                                }
                                .position(x: frame.midX, y: frame.midY)
                            }
                        }
                    }
                }
            }
        }
        .sensoryFeedback(.selection, trigger: selectedDay)
        .onChange(of: selectedWeekday) { oldValue, newValue in
            guard let oldValue, let newValue else { return }
            if oldValue.date.weekdayInt != newValue.date.weekdayInt {
                selectedDay = newValue.date
            }
        }
    }
}

#Preview {
    StepPieChart(chartData: ChartMath.averageWeekdayCount(for: MockData.steps))
}
