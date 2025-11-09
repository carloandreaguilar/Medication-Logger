//
//  AppDependencies.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import SwiftUI
import SwiftData

protocol AppDependencies {
    var modelContainer: ModelContainer { get }
    func makeLogsListViewModel() -> LogsListViewModel
    func makeLogListItemViewModel(log: MedicationLog) -> LogListItemViewModel
    func makeLogDetailViewModel(log: MedicationLog) -> LogDetailViewModel
    func makeNewLogViewModel() -> NewLogViewModel
}

struct DefaultAppDependencies: AppDependencies {
    let modelContainer: ModelContainer
    let dayLabelFormatter = DefaultDayLabelFormatter()
    
    init() {
        self.modelContainer = {
            let schema = Schema([
                MedicationLog.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
    }
    
    func makeLogsListViewModel() -> any LogsListViewModel {
        DefaultLogsListViewModel(modelContext: modelContainer.mainContext, daylabelFormatter: dayLabelFormatter)
    }
    
    func makeLogListItemViewModel(log: MedicationLog) -> LogListItemViewModel {
        DefaultLogListItemViewModel(log: log, dayLabelFormatter: dayLabelFormatter)
    }
    
    func makeLogDetailViewModel(log: MedicationLog) -> any LogDetailViewModel {
        DefaultLogDetailViewModel(log: log, dayLabelFormatter: dayLabelFormatter)
    }
    
    func makeNewLogViewModel() -> NewLogViewModel {
        DefaultNewLogViewModel(modelContext: modelContainer.mainContext, medicationNames: ["Ibuprofen", "Methotrexate", "Prednisone"])
    }
}

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue: AppDependencies = DefaultAppDependencies()
}

extension EnvironmentValues {
    var appDependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
