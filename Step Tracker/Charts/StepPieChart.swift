//
//  StepPieChart.swift
//  Step Tracker
//
//  Created by Alexander on 25.03.2025.
//

import Charts
import SwiftUI

struct StepPieChart: View {
    
    var chartData: [WeekdayChartData]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Label("Averages", systemImage: "calendar")
                    .font(.title3)
                    .foregroundStyle(.pink)
                Text("Last 28 days")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Chart {
                ForEach(chartData) { weekday in
                    SectorMark(angle: .value("Average Steps", weekday.value),
                               innerRadius: .ratio(0.62),
                               angularInset: 1)
                    .foregroundStyle(.pink)
                    .cornerRadius(6)
                    .annotation(position: .overlay) {
                        Text(weekday.value, format: .number.notation(.compactName))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                }
            }
            .frame(height: 240)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
    }
}

#Preview {
    StepPieChart(chartData: ChartMath.averageWeekdayCount(for: HealthMetric.mockData))
}
