//
//  DayLabelFormatter.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation

enum DayLabelFormat {
    case monthDay, monthDayAbbreviated, full
    
    var formatString: String {
        switch self {
        case .monthDay:
            "MMMM d"
        case .monthDayAbbreviated:
            "MMM d"
        case .full:
            "MMMM d yyyy 'at' h:mma"
        }
    }
}

protocol DayLabelFormatter {
    func dayLabel(for date: Date, withFormat format: DayLabelFormat) -> String
}

struct DefaultDayLabelFormatter: DayLabelFormatter {
    private let calendar = Calendar.current
    private let formatter = DateFormatter()
    
    func dayLabel(for date: Date, withFormat format: DayLabelFormat) -> String {
        formatter.dateFormat = format.formatString
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return formatter.string(from: date)
        }
    }
}
