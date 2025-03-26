//
//  DashboardView.swift
//  Step Tracker
//
//  Created by Alexander on 23.03.2025.
//

import Charts
import SwiftUI

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    @State private var isShowingPermissionPrimingSheet = false
    @State private var selectedStat: HealthMetricContext = .steps
    
    var isSteps: Bool {
        selectedStat == .steps
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("SelectedStat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) {
                            Text($0.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    switch selectedStat {
                    case .steps:
                        StepBarChart(selectedStat: selectedStat, chartData: hkManager.stepData)
                        StepPieChart(chartData: ChartMath.averageWeekdayCount(for: hkManager.stepData))
                    case .weight:
                        WeightLineChart(selectedStat: selectedStat, chartData: hkManager.weightData)
                    }
                }
            }
            .padding()
            .task {
                await hkManager.fetchStepsCount()
                await hkManager.fetchWeights()
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $isShowingPermissionPrimingSheet, onDismiss: {
                // fetch data from Health Kit
            }, content: {
                HealthKitPermissionPrimingView(hasSeen: $hasSeenPermissionPriming)
            })
        }
        .tint(isSteps ? .pink : .indigo)
    }
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
