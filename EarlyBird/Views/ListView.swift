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
    @State private var isShowEdit = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: .largeSize) {
                TimelineView()
                TimeControlView()
                List {
                    ForEach($listViewModel.activities) { item in
                        Button(action: {
                            editRoutine(item: item)
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
        .sheet(isPresented: $isShowingSheet, content: {
            NavigationStack {
                AddRoutineView(isShowingSheet: $isShowingSheet, addActivity: { item in
                    listViewModel.addItem(item: item)
                })
            }
        })
        .sheet(isPresented: $isShowEdit, content: {
            NavigationStack {
                EditRoutineView(isShowingSheet: $isShowEdit, vm: EditRoutineViewModel(item: listViewModel.selectedItem, updateActivity: { item in
                    listViewModel.updateActivity(item: item)
                }))
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
    
    func editRoutine(item: Binding<Activity>) {
        listViewModel.selectedItem = item.wrappedValue
        isShowEdit.toggle()
    }
}

#Preview {
    NavigationStack {
        ListView()
    }.environmentObject(ListViewModel())
}
