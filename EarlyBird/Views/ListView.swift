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
        List {
            ForEach(listViewModel.activities) { item in
                ListViewRow(item: item)
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
            
        }
        .listStyle(.plain)
        .navigationTitle("Routines")
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

