//
//  ActionListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import SwiftUI
import CoreData

struct ActionListView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var vm: ActionListViewModel
    @State private var showAddAction = false
    @State private var showInfo = false
    @State private var showEdit = false
    @State private var showDetail = false
    @State private var isShowToggle = false
    
    var menuList = SortOption.allCases
    
    init(habit: Habit) {
        vm = ActionListViewModel(habit: habit)
    }
    
    var body: some View {
        VStack(spacing: .regularSize) {
            VStack {
                HabitTimeView(vm: vm)
//                TimelineSummaryView(vm: vm)
//                TimelineController(vm: vm)
            }
            .padding(.horizontal)
            .onTapGesture {
                showDetail.toggle()
            }
            Divider()
            
            if vm.actions.isEmpty { emptyList }
            // 리스트
            List {
                ForEach(vm.actions) { item in
                    Button(action: {
                        editAction(item: item)
                    }, label: {
                        ActionRow(item: item, isShowToggle: $isShowToggle) { item in
                            vm.updateToggleState(item: item)
                        }
                    })
                }
                .onDelete(perform: vm.deleteItem)
                .onMove(perform: vm.moveItem)
            }.listStyle(.plain)
        }
        
        VStack {
            Button(action: {
                showAddAction.toggle()
            }, label: {
                Label("New Action", systemImage: "plus.circle.fill")
                    .bold()
                    .fontDesign(.serif)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Theme.pill)
            })
        }
        .tint(Theme.pill)
        .padding()
        .navigationTitle(vm.title)
//        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            ToolbarItem(placement: .primaryAction) {
                toolItem
            }
        }
        
        .sheet(isPresented: $showAddAction, content: {
            NavigationStack {
                ActionDetailView(isShowingSheet: $showAddAction, vm: ActionDetailViewModel(habit: vm.habit))
                    .navigationTitle("Add Routine")
            }
        })
        
        .sheet(isPresented: $showEdit, content: {
            NavigationStack {
                ActionDetailView(isShowingSheet: $showEdit, vm: ActionDetailViewModel(action: vm.selectedItem, habit: vm.habit))
                    .navigationTitle("Edit Routine")
            }
        })
        
        .sheet(isPresented: $showDetail, content: {
            NavigationStack {
                HabitDetailView(vm: HabitDetailViewModel(habit: vm.habit))
                    .navigationTitle("Edit Routine")
                
            }
        })
        .onDisappear {
            vm.backButtonTapped()
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave), perform: { output in
            vm.updateHabitData()
        })
    }
    
    var emptyList: some View {
        ContentUnavailableView("Add New Action", systemImage: "pencil.and.scribble", description: Text("add your routine!"))
    }
    
    var addRoutineButton: some View {
        Button {
            showAddAction.toggle()
        } label: {
            Symbols.plus
                .font(.headline)
                .bold()
                .padding(.regularSize)
                .background(Color(uiColor: .label))
                .foregroundColor(Color(uiColor: .systemBackground))
                .clipShape(Circle())
        }
        .padding()
    }
    
    var toolItem: some View {
        Menu {
            Button(action: {
                showDetail.toggle()
            }) {
                Label("Show List Info", systemImage: "info.circle")
                
            }
            
            Button(action: {
                withAnimation(.smooth) {
                    isShowToggle.toggle()
                    vm.updateSortOption(.active)
                    vm.updateSortOrder(.ascend)
                }
            }) {
                Label("\(isShowToggle ? "Hide" : "Show") Toggle Button", systemImage: "slider.horizontal.3")
            }
            
            
            Menu {
                ForEach(SortOption.allCases, id: \.id) { item in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 20)) {
                            vm.updateSortOption(item)
                        }
                    }, label: {
                        if vm.sortOption == item {
                            Label("\(item.rawValue)", systemImage: "checkmark")
                        } else {
                            Text("\(item.rawValue)")
                        }
                    })
                }
                if vm.sortOption.hasOrder {
                    Section {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 20)) {
                                vm.updateSortOrder(.ascend)
                            }
                            
                        }) {
                            if vm.sortOrder == .ascend {
                                Label("\(vm.sortOption.ascend)", systemImage: "checkmark")
                            } else {
                                Text("\(vm.sortOption.ascend)")
                            }
                        }
                        Button(action: {
                            withAnimation(.easeInOut(duration: 20)) {
                                vm.updateSortOrder(.descend)
                                
                            }
                            
                        }) {
                            if vm.sortOrder == .descend {
                                Label("\(vm.sortOption.descend)", systemImage: "checkmark")
                            } else {
                                Text("\(vm.sortOption.descend)")
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
    
    func editAction(item: Action) {
        vm.selectedItem = item
        showEdit.toggle()
    }
}
