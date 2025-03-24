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
}
