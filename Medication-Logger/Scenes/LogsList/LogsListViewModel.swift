//
//  LogsListViewModel.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation
import Observation
import SwiftData

protocol LogsListViewModel {
    var modelContext: ModelContext { get }
    var showingNewLog: Bool { get set }
    func addLog()
    func deleteLogs(_ logsToDelete: [MedicationLog])
    func dayLabel(for date: Date) -> String
}

@Observable
class DefaultLogsListViewModel: LogsListViewModel {
    @ObservationIgnored
    let modelContext: ModelContext
    @ObservationIgnored
    private let dayLabelFormatter: DayLabelFormatter
    
    var showingNewLog = false
    
    init(modelContext: ModelContext, daylabelFormatter: DayLabelFormatter) {
        self.modelContext = modelContext
        self.dayLabelFormatter = daylabelFormatter
    }
    
    func addLog() {
        showingNewLog = true
    }
    
    func deleteLogs(_ logsToDelete: [MedicationLog]) {
        for log in logsToDelete {
            modelContext.delete(log)
        }
        try? modelContext.save()
    }
    
    func dayLabel(for date: Date) -> String {
        dayLabelFormatter.dayLabel(for: date, withFormat: .monthDay)
    }
}
