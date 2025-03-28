//
//  HealthDataListView.swift
//  Step Tracker
//
//  Created by Alexander on 24.03.2025.
//

import SwiftUI

struct HealthDataListView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @Environment(HealthKitData.self) private var hkData
    @State private var isShowingAddData = false
    @State private var isShowingAlert = false
    @State private var writeError: STError = .noData
    @State private var addDataDate: Date = .now
    @State private var valueToAdd = ""
    
    var metric: HealthMetricContext
    
    var listData: [HealthMetric] {
        metric == .steps ? hkData.stepData : hkData.weightData
    }
    
    var body: some View {
        List(listData.reversed()) { item in
            LabeledContent {
                Text(item.value, format: .number.precision(.fractionLength(metric == .steps ? 0 : 1)))
            } label: {
                Text(item.date, format: .dateTime.month().day().year())
                    .accessibilityLabel(item.date.accessibilityDate)
            }
            .accessibilityElement(children: .combine)
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            addDataView
        }
        .toolbar {
            Button("Add data", systemImage: "plus") {
                isShowingAddData = true
            }
        }
    }
    
    var addDataView: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $addDataDate, displayedComponents: .date)
                HStack {
                    Text(metric.title)
                    Spacer()
                    TextField("Value", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 140)
                        .keyboardType(metric == .steps ? .numberPad : .decimalPad)
                }
                .accessibilityElement(children: .combine)
            }
            .navigationTitle(metric.title)
            .alert(isPresented: $isShowingAlert, error: writeError, actions: { writeError in
                switch writeError {
                case .authNotDetermined, .noData, .unableToCompleteRequest, .invalidValue:
                    EmptyView()
                case .sharingDenied(_):
                    Button("Settings") {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    
                    Button("Cancel", role: .cancel) {}
                }
            }, message: { writeError in
                Text(writeError.failureReason)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        isShowingAddData = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addDataToHealthKit()
                    }
                }
            }
        }
    }
    
    private func addDataToHealthKit() {
        guard let value = Double(valueToAdd) else {
            writeError = .invalidValue
            isShowingAlert = true
            valueToAdd = ""
            return
        }
        Task {
            do {
                if metric == .steps {
                    try await hkManager.addStepData(for: addDataDate, value: value)
                    hkData.stepData = try await hkManager.fetchStepsCount()
                } else {
                    try await hkManager.addWeightData(for: addDataDate, value: value)
                    async let weightsForLineChart = hkManager.fetchWeights(daysBack: 28)
                    async let weightsForBarChart = hkManager.fetchWeights(daysBack: 29)
                    
                    hkData.weightData = try await weightsForLineChart
                    hkData.weightDiffData = try await weightsForBarChart
                }
                isShowingAddData = false
            } catch STError.sharingDenied(let quantityType) {
                writeError = .sharingDenied(quantityType: quantityType)
                isShowingAlert = true
            } catch {
                writeError = .unableToCompleteRequest
                isShowingAlert = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthDataListView(metric: .steps)
            .environment(HealthKitManager())
    }
}
