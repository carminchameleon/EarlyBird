//
//  ActionRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import SwiftUI

struct ActionRow: View {
    @ObservedObject var item: Action {
        didSet {
            print("current Item", item)
        }
    }
    @Binding var isShowToggle: Bool
    
    var updateToggleStatus: (Action) -> Void
    
    init(item: Action, isShowToggle: Binding<Bool>, updateToggleStatus: @escaping ((Action)->Void)) {
        self.item = item
        self._isShowToggle = isShowToggle
        self.updateToggleStatus = updateToggleStatus
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
            Text(item.duration.getString())
                .font(.callout)
                .foregroundStyle(Color(uiColor: .systemGray))
        }.opacity(item.isOn ? 1 : 0.3)

    }
}
