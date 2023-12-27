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
            ScrollView {
                VStack(spacing: .largeSize) {
                    ForEach(vm.routines, id: \.id) { routine in
                        NavigationLink {
                            ActivityListView(viewModel: ActivityListViewModel(routine: routine))
                        } label: {
                            RoutineRow(routine: routine)
                        }
                    }
                }
            }.foregroundStyle(Color(uiColor: .darkText))

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
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                   print("setting button tapped")
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.callout)
                })
            }

        }.sheet(isPresented: $isShowAddView, content: {
            NavigationStack {
                
                RoutineSettingView(vm: RoutineSettingViewModel(routine: nil, saveRoutine: { routine in
                    vm.addItem(routine: routine)
                }))
                    .navigationTitle("Add Routine")

            }
        })
    }
}

#Preview {
    RoutineListView()
        .environmentObject(RoutineListViewModel())
}
