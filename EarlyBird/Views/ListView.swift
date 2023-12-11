//
//  ListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var isShowingSheet = false
    
    var body: some View {
        VStack {
            List {
            
                Section(header:TimelineView()) {
                    ForEach(listViewModel.activities) { item in
                        ListViewRow(item: item)
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
            }
            .listStyle(.grouped)
        }
   
        .navigationTitle("Morning Routine")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    isShowingSheet.toggle()
                }

            }
        }
        .sheet(isPresented: $isShowingSheet, content: {
//            AddRoutineView()
            AddRoutineView1(isShowingSheet: $isShowingSheet)
        })
        
    }
    
    func didDismiss() {
        isShowingSheet.toggle()
    }
}

#Preview {
    NavigationStack {
        ListView()
    }.environmentObject(ListViewModel())
}
