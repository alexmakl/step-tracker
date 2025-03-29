//
//  Step_TrackerApp.swift
//  Step Tracker
//
//  Created by Alexander on 23.03.2025.
//

import SwiftUI

@main
struct Step_TrackerApp: App {
    
    let hkManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(hkManager)
        }
    }
}
