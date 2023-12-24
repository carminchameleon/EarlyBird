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
    @State private var isShowInfo = true
 
    var menuList = SortOption.allCases
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: .superLargeSize) {
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
        .padding(.vertical, .regularSize)
        .navigationTitle("Working Routine")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                toolItem
            }
        }
        .sheet(isPresented: $isShowInfo, content: {
            NavigationStack {
//                RoutineSettingView(vm: <#T##RoutineSettingViewModel#>)
            }
        })
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
    
    var toolItem: some View {
        Menu {
            Button(action: {
                
            }) {
                Label("Show List Info", systemImage: "info.circle")
            }
            Menu {
                ForEach(SortOption.allCases, id: \.id) { item in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 20)) {
                            listViewModel.updateSortOption(item)
                        }
                    }, label: {
                        if listViewModel.sortOption == item {
                            Label("\(item.rawValue)", systemImage: "checkmark")
                        } else {
                            Text("\(item.rawValue)")
                        }
                    })
                }
                if listViewModel.sortOption.hasOrder {
                    Section {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 20)) {
                                listViewModel.updateSortOrder(.ascend)
                            }

                        }) {
                            if listViewModel.sortOrder == .ascend {
                                Label("\(listViewModel.sortOption.ascend)", systemImage: "checkmark")
                            } else {
                                Text("\(listViewModel.sortOption.ascend)")
                            }
                        }
                        Button(action: {
                            withAnimation(.easeInOut(duration: 20)) {
                                listViewModel.updateSortOrder(.descend)

                            }

                        }) {
                            if listViewModel.sortOrder == .descend {
                                Label("\(listViewModel.sortOption.descend)", systemImage: "checkmark")
                            } else {
                                Text("\(listViewModel.sortOption.descend)")
                            }
                        }
                    }
                }
            } label: {
                Label("Sort By", systemImage: "arrow.up.arrow.down")
            }
        } label: {
            Label("setting", systemImage: "ellipsis.circle")
        }
    }
}

#Preview {
    NavigationStack {
        ListView()
    }.environmentObject(ListViewModel())
}
