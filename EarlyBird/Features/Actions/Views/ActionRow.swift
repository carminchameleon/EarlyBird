////
////  ActionRow.swift
////  EarlyBird
////
////  Created by Eunji Hwang on 31/12/2023.
////
//
//import SwiftUI
//
//struct ActionRow: View {
//    
//    @Binding var isShowToggle: Bool
//    @ObservedObject var item: Action
//    var timeline: (Date?, Date?)?
//    var updateToggleStatus: (Action) -> Void
//    var startTimeMode: Bool = false
//    
//    init(item: Action, isShowToggle: Binding<Bool>, timeline: (Date?, Date?)? = nil, startTimeMode: Bool = false, updateToggleStatus: @escaping ((Action)->Void)) {
//        self.item = item
//        self._isShowToggle = isShowToggle
//        self.updateToggleStatus = updateToggleStatus
//        self.timeline = timeline
//    }
//
//    var body: some View {
//        HStack {
//            if isShowToggle {
//                Toggle(isOn: $item.isOn, label: {
//                    actionContent
//                })
//                .onChange(of: item.isOn, {
//                    DispatchQueue.main.async {
//                        withAnimation(.easeInOut(duration: 20)) {
//                            updateToggleStatus(item)
//                        }
//                    }
//                })
//            } else {
//                actionContent
//            }
//            
//        }
//        .padding(.vertical, .smallSize)
//    }
//    
//    var actionContent: some View {
//        VStack(alignment: .leading) {
//            Text(item.title)
//                .font(.callout)
//                .bold()
//            Text(item.duration.getString())
//                .font(.callout)
//                .foregroundStyle(Color(uiColor: .systemGray))
//            if timeline != nil {
//                if let startTime = timeline?.0?.convertToString(),
//                   let finishTime = timeline?.1?.convertToString(){
//                    
//                    Text(startTimeMode ? "\(startTime) - \(finishTime)": "\(finishTime) - \(startTime)")
//                        .font(.callout)
//                        .foregroundStyle(Color(uiColor: .systemGray))
//                    
//
//                }
//            
//            }
//            
//        }.opacity(item.isOn ? 1 : 0.3)
//
//    }
//}


//
//  ActionRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import SwiftUI

struct ActionRow: View {
    
    @Binding var isShowToggle: Bool
    @ObservedObject var item: Action
    var timeline: (String, String)?
    var updateToggleStatus: (Action) -> Void
    var startTimeMode: Bool = false
    
    init(item: Action, isShowToggle: Binding<Bool>, timeline: (String, String)? = nil, startTimeMode: Bool = false, updateToggleStatus: @escaping ((Action)->Void)) {
        self.item = item
        self._isShowToggle = isShowToggle
        self.updateToggleStatus = updateToggleStatus
        self.timeline = timeline
    }

    var body: some View {
        HStack {
            if isShowToggle {
                Toggle(isOn: $item.isOn, label: {
                    actionContent
                })
                .onChange(of: item.isOn, {
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 20)) {
                            updateToggleStatus(item)
                        }
                    }
                })
            } else {
                actionContent
            }
            
        }
        .padding(.vertical, .smallSize)
    }
    
    var actionContent: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.callout)
                .bold()
            HStack {
                Text(item.duration.getString())
                    if timeline != nil {
                        if let startTime = timeline?.0, let finishTime = timeline?.1 {
                            Text(startTimeMode ? "\(startTime) - \(finishTime)": "\(finishTime) - \(startTime)")
                                .bold()
                                
                        }
                    }
            }
            .font(.footnote)
            .foregroundStyle(Color(uiColor: .systemGray2))
            .fontWeight(.thin)
        }.opacity(item.isOn ? 1 : 0.7)

    }
}
