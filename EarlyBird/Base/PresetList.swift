//
//  PresetList.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 23/12/2023.
//

import SwiftUI

struct PresetList: View {
    @Binding var isShowingSheet: Bool
    
    @Binding var isShowingAlert: Bool
    
    @Binding var textFieldValue: String
    
    @Binding var hours: Int
    
    @Binding var mins: Int
    
    @State var presetList = [
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
    
    var addActivity: () -> Void
    
    var body: some View {
        VStack {
            Text("Presets")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(presetList, id: \.id) { item in
                        Circle()
                            .fill(Color(UIColor.secondarySystemBackground))
                            .frame(width: 80)
                            .overlay {
                                VStack(spacing: -4) {
                                    Text("\(item.number)")
                                        .font(.title)
                                    Text("\(item.type.rawValue)")
                                        .foregroundStyle(.orange)
                                }
                            }
                            .onTapGesture {
                                presetButtonTapped(item)
                            }
                    }
                }
            }
        }
    }
    
    func presetButtonTapped(_ item: SelectableTime) {
        switch item.type {
        case .hours:
            hours = item.number
            mins = 0
        case .minutes:
            hours = 0
            mins = item.number
        case .seconds:
            break
        }
        
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        if title.isEmpty {
            isShowingAlert.toggle()
            return
        }
    }
    
}

#Preview {
    PresetList(isShowingSheet: .constant(false), isShowingAlert: .constant(false), textFieldValue: .constant(""), hours: .constant(0), mins: .constant(10)) { 
        
    }
}
