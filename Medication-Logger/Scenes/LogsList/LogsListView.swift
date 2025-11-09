//
//  LogsListView.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import SwiftUI
import SwiftData

struct LogsListView: View {
    @Environment(\.appDependencies) private var appDependencies
    @State private var viewModel: LogsListViewModel
    @Query private var logs: [MedicationLog]
   
    init(viewModel: LogsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if logs.isEmpty {
                    ContentUnavailableView("None yet", systemImage: "tray.fill")
                } else {
                    List {
                        ForEach(logsGroupedByDay, id: \.day) { day, logs in
                            Section(viewModel.dayLabel(for: day)) {
                                ForEach(logs, id: \.id) { log in
                                    NavigationLink {
                                        LogDetailView(viewModel: appDependencies.makeLogDetailViewModel(log: log))
                                    } label: {
                                        LogListItemView(viewModel: appDependencies.makeLogListItemViewModel(log: log))
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteLogs)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.addLog) {
                        Label("Add Log", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Medication logs")
        }
        .sheet(isPresented: $viewModel.showingNewLog) {
            NewLogView(viewModel: appDependencies.makeNewLogViewModel())
        }
    }
    
    var logsGroupedByDay: [(day: Date, logs: [MedicationLog])] {
        let groupedByDay = Dictionary(grouping: logs) { log in
            Calendar.current.startOfDay(for: log.timestamp)
        }
        return groupedByDay
            .map { (day: $0.key, logs: $0.value) }
            .sorted { $0.day > $1.day }
    }
    
    private func deleteLogs(offsets: IndexSet) {
        let logsToDelete = offsets.map { offset in
            logs[offset]
        }
        withAnimation {
            viewModel.deleteLogs(logsToDelete)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: MedicationLog.self, configurations: .init(isStoredInMemoryOnly: true))
    let context = container.mainContext
    LogsListView(viewModel: DefaultLogsListViewModel(modelContext: context, daylabelFormatter: DefaultDayLabelFormatter()))
        .modelContainer(for: MedicationLog.self, inMemory: false)
}
