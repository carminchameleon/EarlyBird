//
//  NewActionListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 29/1/2024.
//

import SwiftUI

struct NewActionListView: View {
    @ObservedObject var vm: ActionListViewModel
    init(habit: Habit) {
        vm = ActionListViewModel(habit: habit)
    }
    
    var body: some View {
        VStack(spacing: .regularSize) {
            VStack {
                Ticket(habit: vm.habit)
                    .shadow(radius: 0.5)
            }
            Spacer()
            VStack(spacing: .extraLargeSize) {
                HStack(alignment: .firstTextBaseline) {
                    Text("“")
                        .font(.system(size: 30, weight: .ultraLight, design: .serif))
                    Text("Actions speack \n louder than words.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 26, weight: .ultraLight, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("”")
                        .font(.system(size: 30, weight: .ultraLight, design: .serif))
                }.padding(.horizontal,.extraLargeSize)
                Text("Your journey begins with a single step. \n What's your first action?")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                Button {
                    
                } label: {
                    Text("Add Action")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, .smallSize)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 12))
            }.verticalCenter()
            
            
        }
        .navigationTitle("Start Now")
        .padding()
    }
}

#Preview {
    NavigationStack {
        NewActionListView(habit: Habit.example)
    }

}
