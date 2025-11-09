//
//  LogDetailViewModel.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation

protocol LogDetailViewModel {
    var log: MedicationLog { get }
    var dayLabel: String { get }
}

struct DefaultLogDetailViewModel: LogDetailViewModel {
    let log: MedicationLog
    private let dayLabelFormatter: DayLabelFormatter
    private let timeFormatter: DateFormatter = .withFormat(.hourMinute)
    
    init(log: MedicationLog, dayLabelFormatter: DayLabelFormatter) {
        self.log = log
        self.dayLabelFormatter = dayLabelFormatter
    }
    
    private var time: String {
        return timeFormatter.string(from: log.timestamp)
    }
    
    var dayLabel: String {
        let day = dayLabelFormatter.dayLabel(for: log.timestamp, withFormat: .monthDay)
        return "\(day) at \(time)"
    }
}
