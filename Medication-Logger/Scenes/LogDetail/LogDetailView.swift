//
//  LogDetailView.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import SwiftUI

struct LogDetailView: View {
    private let viewModel: LogDetailViewModel
    
    init(viewModel: LogDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Dosage") {
                    Text(viewModel.log.dosage)
                }
                Section("Time taken") {
                    Text(viewModel.dayLabel)
                }
                if let notes = viewModel.log.notes {
                    Section("Notes") {
                        Text(notes)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
        .navigationTitle(viewModel.log.medicationName)
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    LogDetailView(viewModel: DefaultLogDetailViewModel(log: .example, dayLabelFormatter: DefaultDayLabelFormatter()))
}
