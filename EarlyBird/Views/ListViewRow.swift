//
//  ListViewRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct ListViewRow: View {
    @State var item: Activity
    
    var body: some View {
        HStack {
            Toggle(isOn: .constant(true), label: {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.callout)
                    Text(item.duration.getString())
                        .font(.callout)
                        .foregroundStyle(Color(uiColor: .systemGray))
                }
            })

        }
        .padding(.vertical, .smallSize)
    }
}

#Preview {
    ListViewRow(item: Activity(title: "Drink Hot Water", duration: 60))
}
