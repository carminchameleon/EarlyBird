//
//  HabitTimeView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/1/2024.
//

import SwiftUI

struct HabitTimeView: View {
    @ObservedObject var vm: ActionListViewModel
    
    init(vm: ActionListViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: .regularSize) {
            VStack(alignment: .leading, spacing: .miniSize) {
                Text("\(vm.startLabel) - \(vm.finishLabel)")
                    .font(.title3)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundColor(Theme.detailText)
                HStack {
                    Text("\(vm.startTime.convertToString())")
                        .font(.title)
                        .bold()
                    Image(systemName:"arrow.right")
                        .font(.caption)
                        .foregroundColor(Theme.detailText)
                    Text("\(vm.finishTime.convertToString())")
                        .font(.title)
                        .bold()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: .regularSize))
            HStack {
                Text("Duration")
                    .fontDesign(.serif)
                    .foregroundColor(Theme.detailText)
                if let actions = vm.habit.actions?.allObjects as? [Action] {
                    let duration = actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration }).getString()
                    Text("\(duration)")
                }
            }
            .font(.callout)
            .bold()
        }
    }
}
//
//#Preview {
//    HabitTimeView()
//}

//try 1
//GeometryReader(content: { geometry in
//    HStack {
//        Spacer()
//        VStack {
//            Text("Wake Up")
//            Button {
//                
//            } label: {
//                Text("6: 00 am")
//                    .frame(width: (geometry.size.width - 24) / 3 )
//            }
//            .padding(.vertical, .smallSize)
//            .padding(.horizontal, .largeSize)
//            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: .regularSize))
//        }
//        .frame(width: geometry.size.width / 2.5)
//        VStack {
//            Text("Start Working")
//            Button { } label: {
//                Text("6: 00 am")
//                    .frame(width: (geometry.size.width - 24) / 3 )
//            }
//            .padding(.vertical, .smallSize)
//            .padding(.horizontal, .largeSize)
//            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: .regularSize))
//        }
//        .frame(width: geometry.size.width / 2.5)
//        Spacer()
//    }
//
//        .frame(maxWidth: .infinity, alignment: .center)
//    })
