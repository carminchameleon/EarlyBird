//
//  HabitListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import SwiftUI

struct HabitListView: View {
    @ObservedObject private var vm = HabitListViewModel()
    @State var showAddView: Bool = false
    @State var showEditView: Bool = false
    var selectedId: UUID?
    
    var body: some View {
        NavigationStack {
            if vm.habits.isEmpty {
                ContentUnavailableView(label: {
                    Label("No Routines", systemImage: "tray.fill")
                })
            }
            List {
                ForEach(vm.habits, id:\.objectID) { habit in
                    ZStack {
                        HabitRow(habit: habit)
                        NavigationLink {
                            HabitDetailView(vm: HabitDetailViewModel(habit: habit))
                        } label: {
                            EmptyView()
                        }.opacity(0.0)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .background(Color.clear)
                            .foregroundColor(Color(UIColor.secondarySystemFill))
                            .opacity(0.6))
                    .swipeActions {
                        Button(role: .destructive) {
                            vm.deleteItem(habit.id)
                        } label: {
                            Image(systemName: "trash")
                        }
                        Button {
                            vm.handleShowDetail(habit)
                            showEditView.toggle()
                        } label: {
                            Image(systemName: "info.circle.fill")
                        }
                    }
                    .contextMenu {
                        Button {
                            vm.handleShowDetail(habit)
                            showEditView.toggle()
                        } label: {
                            Label("Show Routine Info", systemImage: "info.circle")
                        }
                        Button(role: .destructive) {
                            vm.deleteItem(habit.id)
                        } label: {
                            Label("Delete Routine", systemImage: "trash")
                        }
                    }
                }
                .onMove(perform: vm.moveItem)
            }
            .listStyle(.insetGrouped)
            .listRowSpacing(.largeSize)
            .scrollContentBackground(.hidden)
            
            VStack {
                Button(action: {
                    showAddView.toggle()
                }, label: {
                    Label("New Routine", systemImage: "plus.circle.fill")
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.accentColor)
                })
            }
            .padding()
            
        }

        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                   print("setting button tapped")
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.callout)
                })
            }

        }.sheet(isPresented: $showAddView, content: {
            NavigationStack {
                HabitDetailView(vm: HabitDetailViewModel())
                    .navigationTitle("Add Routine")

            }
        })
        .sheet(isPresented: $showEditView, content: {
            NavigationStack {
                HabitDetailView(vm: HabitDetailViewModel(habit: vm.selectedItem))
                    .navigationTitle("Edit Routine")
            }
        })
    }
}

#Preview {
    HabitListView()
}
