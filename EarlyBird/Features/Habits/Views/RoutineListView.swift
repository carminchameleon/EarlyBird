//
//  RoutineListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 28/1/2024.
//

import SwiftUI

struct RoutineListView: View {
    @ObservedObject private var vm = HabitListViewModel()
    @State private var xOffset: CGFloat = 0// 초기 위치는 왼쪽 밖
    @State private var shouldAnimate = false
    
    init() {
        let appear = getCustomNavigation()
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
    
    var body: some View {
        ZStack {
            if vm.habits.isEmpty {
                loadingView
            } else {
                NavigationStack {
                    ScrollView {
                        VStack(spacing: .largeSize) {
                            ForEach(vm.habits, id: \.objectID) { habit in
                                NavigationLink(destination: NewActionListView(habit: habit)) {
                                    Ticket(habit: habit)
                                }
                            }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Daily Journey")
        .navigationBarTitleDisplayMode(.large)
        .padding(.regularSize)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        RoutineListView()
            .navigationTitle("Daily Journey")
            .navigationBarTitleDisplayMode(.large)

    }
}

extension RoutineListView {
    var loadingView: some View {
        ZStack {
            VStack(spacing: .regularSize) {
                VStack {
                    Ticket(habit: Habit.onboard)
                        .shadow(radius: 0.5)
                }
                Spacer()
                VStack(spacing: .extraLargeSize) {
                    Text("🛫")
                        .font(.system(size: 80))

                    HStack(alignment: .firstTextBaseline) {
                        
                        Text("“")
                            .font(.system(size: 30, weight: .ultraLight, design: .serif))
                        Text("Buckle up for takeoff")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 26, weight: .ultraLight, design: .serif))
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("”")
                            .font(.system(size: 30, weight: .ultraLight, design: .serif))
                    }
                 
                    .padding(.horizontal,.extraLargeSize)
                    Text("Kickstart your journey to the future \nby making your first ticket. \nyour flight ticket is always in your hands.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                   
                }
                .verticalCenter()
                Button {
                    
                } label: {
                    Text("Add Action")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, .smallSize)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 12))
            }
        }

    }
}


