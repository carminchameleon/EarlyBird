//
//  ActivityRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct ActivityRow: View {
    @Binding var item: Activity
    @Binding var isShowToggle: Bool
    
    init(item: Binding<Activity>, isShowToggle: Binding<Bool>, updateToggleStatus: @escaping ((Activity)->Void)) {
        self._item = item
        self._isShowToggle = isShowToggle
        self.updateToggleStatus = updateToggleStatus
    }
    
    var updateToggleStatus: (Activity) -> Void
    
    var body: some View {
        HStack {
            if isShowToggle {
                Toggle(isOn: $item.isOn, label: {
                    activityContent
                })
                .onChange(of: item.isOn, {
                    withAnimation(.easeInOut(duration: 20)) {
                        updateToggleStatus(item)
                    }
                })
            } else {
               activityContent
            }
            
        }
        .padding(.vertical, .smallSize)
    }

    var activityContent: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.callout)
                .bold()
            
            Text(item.duration.getString())
                .font(.callout)
                .foregroundStyle(Color(uiColor: .systemGray))
        }

    }
}

#Preview {
    ActivityRow(item: .constant(Activity(title: "drink something", duration: 10)), isShowToggle: .constant(true)) { _ in
    }
}
