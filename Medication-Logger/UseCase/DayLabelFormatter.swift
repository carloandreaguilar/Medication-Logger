//
//  DayLabelFormatter.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation

protocol DayLabelFormatter {
    func dayLabel(for date: Date, withFormat format: DateFormat) -> String
}

struct DefaultDayLabelFormatter: DayLabelFormatter {
    private let calendar = Calendar.current
    private let formatter = DateFormatter()
    
    func dayLabel(for date: Date, withFormat format: DateFormat) -> String {
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return DateFormatter.withFormat(format).string(from: date)
        }
    }
}
