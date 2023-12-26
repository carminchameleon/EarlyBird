//
//  ActivityListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct ActivityListView: View {
    @StateObject var viewModel: ActivityListViewModel
    @State private var isShowingSheet = false
    @State private var isShowEdit = false
    @State private var isShowInfo = false
 
    var menuList = SortOption.allCases
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: .superLargeSize) {
                TimelineView(viewModel: viewModel)
                TimeControlView(viewModel: viewModel)
                List {
                    ForEach($viewModel.activities) { item in
                        Button(action: {
                            editRoutine(item: item)
                        }, label: {
                            ActivityRow(item: item) { item in
                                viewModel.updateToggleState(item: item)
                            }
                        })
                    }
                    
                    .onDelete(perform: viewModel.deleteItem)
                    .onMove(perform: viewModel.moveItem)
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
                RoutineSettingView(vm: RoutineSettingViewModel())
                    .navigationTitle("Edit Routine")
            }
        })
        .sheet(isPresented: $isShowingSheet, content: {
            NavigationStack {
                AddActivityView(isShowingSheet: $isShowingSheet, addActivity: { item in
                    viewModel.addItem(item: item)
                })
            }
        })
        .sheet(isPresented: $isShowEdit, content: {
            NavigationStack {
                EditActivityView(isShowingSheet: $isShowEdit, vm: EditActivityViewModel(item: viewModel.selectedItem, updateActivity: { item in
                    viewModel.updateActivity(item: item)
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
        viewModel.selectedItem = item.wrappedValue
        isShowEdit.toggle()
    }
    
    var toolItem: some View {
        Menu {
            Button(action: {
                isShowInfo.toggle()
            }) {
                Label("Show List Info", systemImage: "info.circle")
            }
            Menu {
                ForEach(SortOption.allCases, id: \.id) { item in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 20)) {
                            viewModel.updateSortOption(item)
                        }
                    }, label: {
                        if viewModel.sortOption == item {
                            Label("\(item.rawValue)", systemImage: "checkmark")
                        } else {
                            Text("\(item.rawValue)")
                        }
                    })
                }
                if viewModel.sortOption.hasOrder {
                    Section {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 20)) {
                                viewModel.updateSortOrder(.ascend)
                            }

                        }) {
                            if viewModel.sortOrder == .ascend {
                                Label("\(viewModel.sortOption.ascend)", systemImage: "checkmark")
                            } else {
                                Text("\(viewModel.sortOption.ascend)")
                            }
                        }
                        Button(action: {
                            withAnimation(.easeInOut(duration: 20)) {
                                viewModel.updateSortOrder(.descend)

                            }

                        }) {
                            if viewModel.sortOrder == .descend {
                                Label("\(viewModel.sortOption.descend)", systemImage: "checkmark")
                            } else {
                                Text("\(viewModel.sortOption.descend)")
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
        ActivityListView(viewModel: ActivityListViewModel(routine: Routine.mockedRoutine))
    }
}
