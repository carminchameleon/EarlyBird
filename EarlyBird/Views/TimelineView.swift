//
//  TimelineView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/12/2023.
//

import SwiftUI

struct TimelineView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("⏰ Wake Up")
            Group {
                HStack(alignment: .center, spacing: 0) {
                    Text(listViewModel.calculatedTime.getNumberOfTime())
                        .font(.largeTitle.weight(.semibold))
                    
                    Text(listViewModel.calculatedTime.getDayOfTime())
                        .font(.title.weight(.semibold))
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: .mediumSize)
                    .inset(by: 1)
                    .stroke(Color(UIColor.secondarySystemBackground), lineWidth: 3)
            )
        }.padding(.horizontal)
    }
}

#Preview {
    TimelineView()
        .environmentObject(ListViewModel())
}
