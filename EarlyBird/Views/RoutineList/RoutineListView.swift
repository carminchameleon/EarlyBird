//
//  RoutineListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import SwiftUI

struct RoutineListView: View {
    @EnvironmentObject var vm: RoutineListViewModel
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100))
       ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                LazyVGrid(columns: columns, content: {
                    GeometryReader(content: { geometry in
                        Rectangle()
                          .fill(Color.red)
//                          .aspectRatio(contentMode: .fit)
//                          .frame(width: geometry.size.width * 0.5)
                        
                    })
                                  Rectangle()
                                      .fill(Color.red)
                                      
                }).gridCellColumns(2)
            }.padding()

            //
//            List(vm.routines, id: \.self) { routine in
//                NavigationLink {
//                    ActivityListView(viewModel: ActivityListViewModel(routine: routine))
//                } label: {
//                    
//                    HStack {
//                        Label(routine.title, systemImage: "tray").tint(.gray)
//                        Spacer()
//                    }
//                }
//           }
       }
    }
}

#Preview {
    RoutineListView()
        .environmentObject(RoutineListViewModel())
}
