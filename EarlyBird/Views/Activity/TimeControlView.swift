//
//  TimeControlView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 13/12/2023.
//

import SwiftUI

struct TimeControlView: View {
    @ObservedObject var viewModel: ActivityListViewModel

    var body: some View {
        HStack {
            HStack {
                Text("⏳ Duration")
                    .foregroundStyle(Color(uiColor: .systemGray))
                Text(viewModel.duration.getString())
            }
            
            Spacer()
            
            HStack {
                Text(viewModel.standardLabel)
                    .foregroundStyle(Color(uiColor: .systemGray))
                DatePicker("",selection: $viewModel.standardTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
                    .clipped()
                    .labelsHidden()
            }
        }
        .padding(.horizontal)
        .font(.subheadline)
        .scaledToFit()
        .minimumScaleFactor(0.5)
        .lineLimit(1)

    }
}

#Preview {
    TimeControlView(viewModel: ActivityListViewModel(routine: Routine.mockedRoutine))
}
