//
//  LogListItemView.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
//

import SwiftUI

struct LogListItemView: View {
    var viewModel: LogListItemViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.log.medicationName)
                    .font(.subheadline)
                Text(viewModel.log.dosage)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(viewModel.dayLabel)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text(viewModel.log.timestamp, style: .time)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    LogListItemView(viewModel: DefaultLogListItemViewModel(log: .example, dayLabelFormatter: DefaultDayLabelFormatter()))
}
