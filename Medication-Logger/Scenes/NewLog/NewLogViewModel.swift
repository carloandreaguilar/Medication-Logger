//
//  NewLogViewModel.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation
import Observation
import SwiftData
import Combine

protocol NewLogViewModel {
    var modelContext: ModelContext { get }
    var medicationNames: [String] { get }
    var selectedMedication: String? { get set }
    var dosage: String { get set }
    var timeTaken: Date { get set }
    var currentTime: Date { get set }
    var notes: String { get set }
    var useCurrentTime: Bool { get set }
    var isMissingRequiredFields: Bool { get }
    var currentDateFormatted: String { get }
    func saveLog() throws
}

@Observable
class DefaultNewLogViewModel: NewLogViewModel {
    @ObservationIgnored
    let modelContext: ModelContext
    @ObservationIgnored
    let medicationNames: [String]
    var selectedMedication: String?
    var dosage: String = ""
    var timeTaken: Date
    var currentTime: Date
    var notes = ""
    var useCurrentTime = true
    private var timerCancellable: AnyCancellable?
    
    private let timeFormatter: DateFormatter = .withFormat(.hourMinute)
    
    init(modelContext: ModelContext, medicationNames: [String]) {
        self.modelContext = modelContext
        self.medicationNames = medicationNames
        let now = Date.now
        self.currentTime = now
        self.timeTaken = now
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] now in
                guard let self else { return }
                self.currentTime = .now
                if self.useCurrentTime {
                    self.timeTaken = currentTime
                }
            }
    }
    
    var isMissingRequiredFields: Bool {
        selectedMedication == nil || dosage.isEmpty
    }
    
    var currentDateFormatted: String {
        "Today at \(timeFormatter.string(from: currentTime))"
    }
    
    func saveLog() throws {
        guard let selectedMedication = selectedMedication else {
            throw NSError()
        }
        let newLog = MedicationLog(medicationName: selectedMedication, dosage: dosage, timestamp: timeTaken, notes: notes.isEmpty ? nil : notes)
        modelContext.insert(newLog)
        try modelContext.save()
    }
}
