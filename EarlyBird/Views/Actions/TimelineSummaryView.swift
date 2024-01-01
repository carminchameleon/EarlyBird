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
        VStack(alignment: .leading, spacing: .largeSize) {
            VStack {
                calculatedTitle
                calculatedTime
            }
    
            HStack {
                duration
                Spacer()
                standard
            }
            .font(.subheadline)
            .scaledToFit()
            .minimumScaleFactor(0.5)
            .lineLimit(1)
        }
        .padding(.horizontal)
    
    }
    
    var calculatedTitle: some View {
        HStack {
            Text(vm.startTimeMode ? "🚀" : "🏁")
            Text(vm.calculatedLabel)
            Spacer()
            Button {
                withAnimation(.snappy) {
                    vm.switchButtonTapped()
                }
            } label: {
                Image(systemName: "arrow.left.arrow.right")
                    .font(.caption)
                Text("Switch")
            }
            .foregroundColor(.accentColor)
        }
    }
    
    var calculatedTime: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Text(vm.calculatedTime.getNumberOfTime())
                    .font(.largeTitle.weight(.semibold))
                Text(vm.calculatedTime.getDayOfTime())
                    .font(.title2.weight(.semibold))
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
    
    var duration: some View {
        HStack {
            Text("⏳ Duration")
                .foregroundStyle(Color(uiColor: .systemGray))
            Text(vm.duration.getString())
        }
    }
    
    var standard: some View {
        HStack {
            Text(vm.startTimeMode ? "🏁": "🚀" )
            Text(vm.standardLabel)
                .foregroundStyle(Color(uiColor: .systemGray))
            DatePicker("",selection: $vm.standardTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(CompactDatePickerStyle())
                .clipped()
                .labelsHidden()
        }
    }
}
