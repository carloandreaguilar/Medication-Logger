//
//  NewLogView.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import SwiftUI
import Combine
import SwiftData

struct NewLogView: View {
    @State private var viewModel: NewLogViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: NewLogViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Medication", selection: $viewModel.selectedMedication) {
                    ForEach(viewModel.medicationNames, id: \.self) { medicationName in
                        Text(medicationName)
                            .tag(medicationName as String?)
                    }
                }
                .pickerStyle(.inline)
                
                Section("Dosage") {
                    TextField("10mg, 20mg...", text: $viewModel.dosage)
                }
                
                Section("Time Taken") {
                    HStack {
                        Text(viewModel.useCurrentTime ? "Current time:" : "Custom time:")
                            .foregroundStyle(.secondary)
                        if viewModel.useCurrentTime {
                            HStack {
                                
                                Text(viewModel.timeTaken, style: .time)
                                Spacer()
                                Button("Change") {
                                    viewModel.useCurrentTime = false
                                }
                            }
                        } else {
                            DatePicker(
                                "",
                                selection: $viewModel.timeTaken,
                                in: ...Date(),
                                displayedComponents: [.date, .hourAndMinute])
                        }
                        Spacer()
                        
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
                Section("Notes") {
                    TextEditor(text: $viewModel.notes)
                        .frame(minHeight: 100)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.saveLog()
                            dismiss()
                        } catch { }
                        
                    }
                    .disabled(viewModel.isMissingRequiredFields)
                }
            }
            .navigationTitle("New log")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}
//
//#Preview {
//    NewLogView(medicationNames: ["Ibuprofen", "Methotrexate", "Prednisone"])
//}
