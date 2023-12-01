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
            Text(item.title)
                .font(.title2)
            Spacer()
            Text(item.duration.getString())
                .font(.title3)
        }
        .padding(.vertical, .smallSize)
    }
}

#Preview {
    ListViewRow(item: Activity(title: "Drink Hot Water", duration: 60))
}
