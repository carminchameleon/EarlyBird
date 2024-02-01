//
//  NewActionListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 29/1/2024.
//

import SwiftUI

struct NewActionListView: View {
    @ObservedObject var vm: NewActionListViewModel
    
    @State private var showAddAction = false
    @State private var showEditAction = false
    @State private var isShowToggle = false
    
    init(habit: Habit) {
        vm = NewActionListViewModel(habit: habit)
        let appear = getCustomNavigation()
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
    
    var body: some View {
        VStack {
            ActionTicket(vm: vm)
                .shadow(radius: 5)
                .padding(.largeSize)

            if vm.actions.isEmpty {
                EmptyActionView {
                    showAddAction.toggle()
                    // add button tapped
                }
            } else {
                List {
                    ForEach(vm.actions) { item in
                        Button(action: {
                            vm.selectedItem = item
                            showEditAction.toggle()
                        }, label: {
                            ActionRow(item: item, isShowToggle: $isShowToggle, timeline: vm.timelines[item.id]) { item in
//                                vm.updateToggleState(item: item)
                            }
                        })
                        .swipeActions {
                            Button(role: .destructive) {
                                vm.deleteItem(id: item.id)
                            } label: {
                                Symbols.trash
                            }
                        }
                    }
                    .onMove(perform: vm.moveItem)
                }
                .tint(Color.theme.accent)
                .listStyle(.plain)
            }
            VStack {
                Button(action: {
                    showAddAction.toggle()
                }, label: {
                    Label("New Action", systemImage: "plus.circle.fill")
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.accentColor)
                })
            }.padding(.regularSize)
        }
        .navigationTitle("Starting Now")
        
        .sheet(isPresented: $showAddAction, content: {
            NavigationStack {
                ActionDetailView(isShowingSheet: $showAddAction, vm: ActionDetailViewModel(habit: vm.habit))
                    .navigationTitle("Add Action")
            }
        })
        .sheet(isPresented: $showEditAction, content: {
            NavigationStack {
                ActionDetailView(isShowingSheet: $showEditAction, vm: ActionDetailViewModel(action: vm.selectedItem, habit: vm.habit))
                    .navigationTitle("Edit Action")
            }
        })
        // 바뀐 데이터 저장
        .onDisappear {
            vm.backButtonTapped()
        }
        // maybe action 바뀌었을 때
        .onReceive(NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave), perform: { output in
            vm.updateHabitData()
        })
    }
}

#Preview {
    NavigationStack {
        NewActionListView(habit: Habit.example)
        
    }
}
