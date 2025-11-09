//
//  DateFormatter+Extensions.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 10/11/25.
//

import Foundation

enum DateFormat {
    case monthDay, monthDayAbbreviated, hourMinute
    
    var formatString: String {
        switch self {
        case .monthDay:
            "MMMM d"
        case .monthDayAbbreviated:
            "MMM d"
        case .hourMinute:
            "h:mma"
        }
    }
}

extension DateFormatter {
    static func withFormat(_ format: DateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.formatString
        return formatter
    }
}
