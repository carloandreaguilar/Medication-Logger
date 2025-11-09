//
//  LogDetailViewModel.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation

protocol LogDetailViewModel {
    var log: MedicationLog { get }
    var formattedDate: String { get }
}

struct DefaultLogDetailViewModel: LogDetailViewModel {
    var log: MedicationLog
    private let formatter = DateFormatter()
    
    init(log: MedicationLog) {
        self.log = log
        self.formatter.dateFormat = "MMMM d yyyy 'at' h:mma"
    }
    
    var formattedDate: String {
        return formatter.string(from: log.timestamp)
    }
}
