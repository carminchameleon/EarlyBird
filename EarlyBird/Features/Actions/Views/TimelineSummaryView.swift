//
//  TimelineSummaryView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import SwiftUI

struct TimelineSummaryView: View {
    @ObservedObject var vm: ActionListViewModel
    
    init(vm: ActionListViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            calculatedTitle
            finishTime
        }
        .tint(Theme.pill)
        .frame(maxWidth: .infinity)
    }
    
    var calculatedTitle: some View {
        HStack {
            Text(vm.startTimeMode ? "🏁" : "🚀")
            Text(vm.finishLabel)
                .fontDesign(.serif)
                .font(.title3)
                .bold()
            
            Spacer()
            Button {
                withAnimation(.snappy) {
                    vm.switchButtonTapped()
                }
            } label: {
                Symbols.switchMode
                Text("Switch")
            }.font(.caption)
        }
    }
    
    var finishTime: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
//                Text(vm.finishTime.getNumberOfTime())
//                    .font(.largeTitle.weight(.semibold))
//                Text(vm.finishTime.getDayOfTime())
//                    .font(.title2.weight(.semibold))
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}
