//
//  RoutineListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import SwiftUI

struct RoutineListView: View {
    @EnvironmentObject var vm: RoutineListViewModel
    @State var isShowAddView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.routines, id: \.id) { routine in
                    NavigationLink {
                        ActivityListView(viewModel: ActivityListViewModel(routine: routine))
                    } label: {
                        HStack {
                            RoutineRow(routine: routine)
                        }
                    }
                }
                .onMove(perform: vm.moveItem)
                .onDelete(perform: vm.deleteItem)
            }
            .padding(.vertical, .largeSize)
            .listStyle(.plain)

            VStack {
                Button(action: {
                    isShowAddView.toggle()
                }, label: {
                    Label("New Routine", systemImage: "plus.circle.fill")
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.accentColor)
                })

            }
            .padding()
            
        }.toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                   print("setting button tapped")
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.callout)
                })
            }
            ToolbarItem(placement: .cancellationAction) {
               EditButton()
            }

        }.sheet(isPresented: $isShowAddView, content: {
            NavigationStack {
                RoutineSettingView(vm: RoutineSettingViewModel())
                    .navigationTitle("Add Routine")

            }
        })
    }
}

#Preview {
    RoutineListView()
        .environmentObject(RoutineListViewModel())
}
