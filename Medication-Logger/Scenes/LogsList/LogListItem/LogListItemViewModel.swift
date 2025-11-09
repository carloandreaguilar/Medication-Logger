//
//  LogListItemViewModel.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation

protocol LogListItemViewModel {
    var log: MedicationLog { get }
    func dayLabel(for date: Date) -> String
}

struct DefaultLogListItemViewModel: LogListItemViewModel {
    let log: MedicationLog
    let dayLabelFormatter: DayLabelFormatter
    
    func dayLabel(for date: Date) -> String {
        dayLabelFormatter.dayLabel(for: date, withFormat: .monthDayAbbreviated)
    }
}
