//
//  RoutineListView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 28/1/2024.
//

import SwiftUI

struct RoutineListView: View {
    @ObservedObject private var vm = HabitListViewModel()
    
    init() {
        let appear = UINavigationBarAppearance()
        let atters: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .black)
        ]
        appear.configureWithTransparentBackground()
        appear.largeTitleTextAttributes = atters
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
    
    
    @State private var xOffset: CGFloat = -200 // 초기 위치는 왼쪽 밖
    @State private var shouldAnimate = false

    
    var body: some View {
        ZStack {

            NavigationStack {
                ScrollView {
                    if vm.habits.isEmpty {
                        VStack(spacing: .extraLargeSize) {
                            Text("🛫")
                                .frame(width: 100, height: 100)
                                .font(.system(size: 50))
                                .offset(x: shouldAnimate ? 240 : -220)
                                .offset(y: shouldAnimate ? -20 : 20)
                                .animation(.easeInOut(duration: 3.0), value: shouldAnimate)
                                .onAppear(perform: {
                                    shouldAnimate.toggle()
                                })
                            HStack(alignment: .firstTextBaseline) {
                                
                                Text("“")
                                    .font(.system(size: 30, weight: .ultraLight, design: .serif))
                                Text("Buckle up for takeoff")
//                                Text("Buckle up for takeoff \n your flight ticket is \n in your hands.")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 26, weight: .ultraLight, design: .serif))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("”")
                                    .font(.system(size: 30, weight: .ultraLight, design: .serif))
                            }
                            .padding(.horizontal,.extraLargeSize)
                            
                            Ticket(habit: Habit.onboard)
                                
                            Text("Kickstart your journey to the future \nby making your first ticket. \nyour flight ticket is always in your hands.")
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .font(.caption)
                            Button {
                                
                            } label: {
                                Text("Add Action")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, .smallSize)
                            }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle(radius: 12))
                        }
                        .verticalCenter()
                       
                    }
                    
                    
                    VStack(spacing: .largeSize) {
                        ForEach(vm.habits, id: \.objectID) { habit in
                                NavigationLink(destination: ActionListView(habit: habit)) {
                                    Ticket(habit: habit)
                                }
                            }
                        }
                    }
                }
            }
        
            .navigationTitle("Daily Journey")
            .navigationBarTitleDisplayMode(.large)
            .padding(.regularSize)
            .backgroundStyle(Color(uiColor: .gray))
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
