//
//  LogListItemViewModel.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation

protocol LogListItemViewModel {
    var log: MedicationLog { get }
    var dayLabel: String { get }
}

struct DefaultLogListItemViewModel: LogListItemViewModel {
    let log: MedicationLog
    private let dayLabelFormatter: DayLabelFormatter
    
    init(log: MedicationLog, dayLabelFormatter: DayLabelFormatter) {
        self.log = log
        self.dayLabelFormatter = dayLabelFormatter
    }
    
    var dayLabel: String {
        dayLabelFormatter.dayLabel(for: log.timestamp, withFormat: .monthDayAbbreviated)
    }
}
