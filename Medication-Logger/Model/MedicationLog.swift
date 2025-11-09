//
//  MedicationLog.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import Foundation
import SwiftData

@Model
final class MedicationLog {
    @Attribute(.unique) var id: UUID
    var medicationName: String
    var dosage: String
    var timestamp: Date
    var notes: String?
    
    init(id: UUID = UUID(), medicationName: String, dosage: String, timestamp: Date, notes: String? = nil) {
        self.id = id
        self.medicationName = medicationName
        self.dosage = dosage
        self.timestamp = timestamp
        self.notes = notes
    }
}

extension MedicationLog {
    static var example: MedicationLog {
        MedicationLog(medicationName: "Ibuprofen", dosage: "20mg", timestamp: .now, notes: "Taken with dinner")
    }
}
