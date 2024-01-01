//
//  ToolBarPresetTime.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import SwiftUI

struct ToolBarPresetTime: View {
    @Binding var selectedTime: TimeInterval
    var buttonTapped: (TimeInterval) -> Void
    
    var presetList = [
        SelectableTime(type: .minutes, number: 1),
        SelectableTime(type: .minutes, number: 2),
        SelectableTime(type: .minutes, number: 3),
        SelectableTime(type: .minutes, number: 4),
        SelectableTime(type: .minutes, number: 5),
        SelectableTime(type: .minutes, number: 10),
        SelectableTime(type: .minutes, number: 15),
        SelectableTime(type: .minutes, number: 20),
        SelectableTime(type: .hours, number: 1),
        SelectableTime(type: .hours, number: 2),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(presetList, id: \.id) { item in
                    Button(action: {
                        selectTime(item: item)
                    }, label: {
                        Text("\(item.number)")
                            .bold()
                        Text("\(item.type.rawValue)")
                            .font(.callout)
                            .foregroundStyle(.orange)
                    })
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    func selectTime(item: SelectableTime) {
        var duration: Double = 0
        switch item.type {
        case .hours:
            duration = Double(item.number) * 3600
            
        case .minutes:
            duration = Double(item.number) * 60
            
        case .seconds:
            break
        }
        
        self.selectedTime = duration
        buttonTapped(duration)
    }
}
//
//#Preview {
//    ToolBarPresetTime { _ in
//        
//    }
//}
