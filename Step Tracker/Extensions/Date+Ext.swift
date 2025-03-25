//
//  Date+Ext.swift
//  Step Tracker
//
//  Created by Alexander on 25.03.2025.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
}
