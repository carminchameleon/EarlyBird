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
        ZStack(alignment: .bottomTrailing) {
            VStack {
                TimelineView()
                    .padding(.bottom, 50)
                TimeControlView()
                List {
                    ForEach(listViewModel.activities) { item in
                        ListViewRow(item: item)
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(.plain)
            }
            
            AddRoutineButton()
        }
  
        .navigationTitle("Working Routine")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(isPresented: $isShowingSheet, content: {
            AddRoutineView1(isShowingSheet: $isShowingSheet)
        })
        
    }

}

#Preview {
    NavigationStack {
        ListView()
    }.environmentObject(ListViewModel())
}

struct AddRoutineButton: View {
    var body: some View {
        Button {
        } label: {
            Image(systemName: "plus")
                .font(.headline)
                .bold()
                .padding(.smallSize)
                .background(Color(uiColor: .label))
                .foregroundColor(Color(uiColor: .systemBackground))
                .clipShape(Circle())
        }
        .padding()
    }
}
