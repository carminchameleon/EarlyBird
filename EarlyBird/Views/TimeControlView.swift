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
            
            HStack(alignment: .center, spacing: 0){
                Text("✅ End Time")
                    .foregroundStyle(Color(uiColor: .systemGray))
                DatePicker("",selection: $listViewModel.endPoint, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.automatic)
            }
        }
        .padding(.horizontal)
        .font(.subheadline)
    }
}

#Preview {
    TimeControlView()
        .environmentObject(ListViewModel())
}
