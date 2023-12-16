//
//  ListViewRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct ListViewRow: View {
    @State var item: Activity
    
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
// 이 내부에서 값이 바뀌면, 그것을 업데이트 해야 하는데...


#Preview {
    ListViewRow(item: Activity(title: "Drink Hot Water", duration: 60)) { _ in
        
    }
}
