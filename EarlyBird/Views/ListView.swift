//
//  ListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: .extraLargeSize) {
                HStack {
                    Text("💼 START WORK")
                    Spacer()
                    Text("8:00 AM")
                }
            }
            .padding(.horizontal, .extraLargeSize)
            .bold()
            .padding(.vertical, .largeSize)

            
            VStack {
                List {
                    ForEach(listViewModel.activities) { item in
                        ListViewRow(item: item)
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
    
                }
                .listStyle(.plain)
            }
            
            VStack(spacing: .extraLargeSize) {
                HStack {
                    Text("Duration")
                    Spacer()
                    Text("45 min")
                }
                HStack {
                    Text("🥱 YOU NEED TO WAKE UP")
                    Spacer()
                    Text("10:00 pm")
                }

            }
            .padding(.horizontal, .extraLargeSize)
            .bold()
            .padding(.vertical, .largeSize)
        }
   
        .navigationTitle("Morning Routine")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Add") {
                    AddRoutineView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView()
    }.environmentObject(ListViewModel())
}

