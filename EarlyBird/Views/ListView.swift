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
            VStack(spacing: .largeSize) {
                TimelineView()
                TimeControlView()
                
                List {
                    ForEach(listViewModel.activities) { item in
                        Button(action: {
                            print("on tapped")
                        }, label: {
                            ListViewRow(item: item) { item in
                                listViewModel.updateToggleState(item: item)
                            }
                        })
                    }
                    
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(.plain)
            }
            AddRoutineButton
        }
  
        .navigationTitle("Working Routine")
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                EditButton()
//            }
//        }
        .sheet(isPresented: $isShowingSheet, content: {
            NavigationStack {
                AddRoutineView(isShowingSheet: $isShowingSheet)
            }
        })
        
    }

    var AddRoutineButton: some View {
        Button {
            isShowingSheet.toggle()
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

#Preview {
    NavigationStack {
        ListView()
    }.environmentObject(ListViewModel())
}
