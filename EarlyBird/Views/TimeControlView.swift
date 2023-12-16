//
//  TimeControlView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 13/12/2023.
//

import SwiftUI

struct TimeControlView: View {
    @EnvironmentObject var listViewModel: ListViewModel

    var body: some View {
        HStack {
            HStack {
                Text("⏳ Duration")
                    .foregroundStyle(Color(uiColor: .systemGray))
                Text(listViewModel.duration.getString())
            }
            
            Spacer()
            
            HStack {
                Text("✅ End Time")
                    .foregroundStyle(Color(uiColor: .systemGray))
                DatePicker("",selection: $listViewModel.endPoint, displayedComponents: .hourAndMinute)
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
    TimeControlView()
        .environmentObject(ListViewModel())
}
