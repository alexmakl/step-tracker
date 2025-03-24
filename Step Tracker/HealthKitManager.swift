//
//  HealthKitManager.swift
//  Step Tracker
//
//  Created by Alexander on 24.03.2025.
//

import Foundation
import HealthKit

@Observable class HealthKitManager {
    
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
    
//    func addSimulatorData() async {
//        var sampleObjects: [HKQuantitySample] = []
//        
//        for i in 0..<28 {
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4_000...20_000))
//            let weightQuantity = HKQuantity(unit: .pound(), doubleValue: .random(in: (160 + Double(i/3)...165 + Double(i/3))))
//            
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .day, value: -i+1, to: .now)!
//            
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
//            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass), quantity: weightQuantity, start: startDate, end: endDate)
//            
//            sampleObjects.append(stepSample)
//            sampleObjects.append(weightSample)
//        }
//        
//        
//        try! await store.save(sampleObjects)
//        print("✅ Mock Data sent up")
//    }
}
