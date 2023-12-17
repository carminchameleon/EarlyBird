//
//  ListViewRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct ListViewRow: View {
    @Binding var item: Activity
    
    init(item: Binding<Activity>, updateToggleStatus: @escaping ((Activity)->Void)) {
        self._item = item
        self.updateToggleStatus = updateToggleStatus
    }
    
    var updateToggleStatus: (Activity) -> Void
    
    var body: some View {
        HStack {
            Toggle(isOn: $item.isOn, label: {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.callout)
                    Text(item.duration.getString())
                        .font(.callout)
                        .foregroundStyle(Color(uiColor: .systemGray))
                }
            })
            .onChange(of: item.isOn, {
                updateToggleStatus(item)
            })
        }
        .padding(.vertical, .smallSize)
    }
}

#Preview {
    ListViewRow(item: .constant(Activity(title: "drink something", duration: 10))) { _ in        
    }
}
