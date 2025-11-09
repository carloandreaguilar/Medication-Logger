//
//  Medication_LoggerApp.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import SwiftUI
import SwiftData

@main
struct Medication_LoggerApp: App {
    private let dependencies: AppDependencies = DefaultAppDependencies()

    var body: some Scene {
        WindowGroup {
            LogsListView(viewModel: dependencies.makeLogsListViewModel())
        }
        .modelContainer(dependencies.modelContainer)
        .environment(\.appDependencies, dependencies)
    }
}
