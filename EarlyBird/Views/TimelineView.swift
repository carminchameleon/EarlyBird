//
//  TimelineView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/12/2023.
//

import SwiftUI

struct TimelineView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        HStack {
            
            VStack {
                Text("🥱")
                    .font(.title)
                Text(listViewModel.calculatedTime)
            }
            
            Spacer()
            
            VStack {
                Text("⏳")
                Text(listViewModel.duration.getString())
            }
            .font(.footnote)
            .foregroundStyle(Color(UIColor.secondaryLabel))
            
            Spacer()
            
            VStack {
                Text("🧳")
                    .font(.title)
                Text("8:00 AM")
            }
            
            
        }
        .padding()
    }
}

#Preview {
    TimelineView()
        .environmentObject(ListViewModel())
}


