//
//  ActionListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import SwiftUI
import CoreData

struct ActionListView: View {
    @ObservedObject var vm: ActionListViewModel
    @State private var showAddAction = false
    @State private var showInfo = false
    @State private var showEdit = false
    @State private var isShowToggle = false
    var menuList = SortOption.allCases
    
    var body: some View {
        // for time line button
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: .superLargeSize) {
                TimelineSummaryView(vm: vm)
                if vm.actions.isEmpty { emptyList }
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
                    
                }
            }            
            addRoutineButton
        }
        .padding(.vertical, .regularSize)
        .navigationTitle(vm.title)
        .navigationBarTitleDisplayMode(.inline)
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
            Image(systemName: "plus")
                .font(.headline)
                .bold()
                .padding(.regularSize)
                .background(Color(uiColor: .label))
                .foregroundColor(Color(uiColor: .systemBackground))
                .clipShape(Circle())
        }
        .padding()
    }
    
    func editAction(item: Action) {
        vm.selectedItem = item
        showEdit.toggle()
    }
//    func editAction(item: Binding<Action>) {
//        vm.selectedItem = item.wrappedValue
//        showEdit.toggle()
//    }
}

//#Preview {
//    ActionListView()
//}
