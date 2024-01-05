//
//  NewHabitView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 4/1/2024.
//

import SwiftUI

class NewHabitViewModel: ObservableObject {
    @Published var habit: Habit
    
    @Published var title: String
    @Published var startLabel: String
    @Published var startTime: Date?
    @Published var finishLabel: String
    @Published var finishTime: Date?
    @Published var startTimeMode: Bool

    init(habit: Habit) {
        self.title = habit.title
        self.startLabel = habit.startLabel
        self.startTime = habit.startTime
        self.finishTime = habit.finishTime
        self.finishLabel = habit.finishLabel
        self.startTimeMode = habit.startTimeMode
        self.habit = habit
    }
}

struct NewHabitView: View {
    @ObservedObject var vm: HabitDetailViewModel
    @State private var showAdjust = false
    @State private var showDetail = false
    
    @State private var longPressGestureActive = false
    @State private var feedbackGenerator: UINotificationFeedbackGenerator? = nil

    
    init(habit: Habit) {
        self.vm = HabitDetailViewModel(habit: habit)
    }
    
    enum startTimeMode: String, CaseIterable, Identifiable {
        case start = "Start Time"
        case finish = "Finish Time"
        var id: Self { self }
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            ScrollView {
                GeometryReader(content: { geometry in
                    VStack(spacing: .largeSize) {
                        VStack {
                            Text(vm.startTime.convertToString())
                                .font(.system(size: 45))
                                .fontDesign(.serif)
                                .bold()
                            Text(vm.startLabel)
                                .font(.headline)
                        }
                        .overlay(alignment: .top) {
                            ArcShape(startAngle: .degrees(0), endAngle: .degrees(180))
                                .stroke(Theme.subText, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                .frame(width: 280, height: 280)
                                .padding(.top, -80)
                        }
                        
                        Divider()
                        
                        VStack(spacing: .smallSize) {
                            Text(vm.title)
                                .bold()
                            if let actions = vm.habit?.actions?.allObjects as? [Action] {
                                let duration = actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration }).getString()
                                Text("\(duration)")
                                    .foregroundStyle(Theme.subText)
                            }
                        }
                        .font(.title3)
                        .fontDesign(.serif)
                        
                        if let actions = vm.habit?.actions?.allObjects as? [Action], !actions.isEmpty {
                            HStack {
                                Text(vm.finishLabel)
                                Text(vm.finishTime.convertToString())
                            }
                            .font(.callout)
                        }
                    }
                    .padding(.top, geometry.size.width * 0.5)
                    .padding(.horizontal, 50)
                })
            }
            VStack {
                Button(action: {
                    showAdjust.toggle()
                }, label: {
                    Text("ADJUST TIME")
                })
            }
        }.gesture (
            LongPressGesture(minimumDuration: 0.3)
                                   .onChanged { _ in
                                       feedbackGenerator = UINotificationFeedbackGenerator()
                                       feedbackGenerator?.prepare()
                                       feedbackGenerator?.notificationOccurred(.error)
                                       longPressGestureActive = true
                                   }
                                   .onEnded { _ in
                                       if longPressGestureActive {
                                           showDetail.toggle()
                                       }
                                       feedbackGenerator = nil
                                       longPressGestureActive = false
                                   })

        .fullScreenCover(isPresented: $showDetail) {
            if let habit = vm.habit {
                NavigationStack {
                    ActionListView(habit: habit)
                }
            }
        }
        .sheet(isPresented: $showAdjust, content: {
            VStack (alignment: .center, spacing: 20) {
                HStack(spacing: 20) {
                    Text("STANDARD OF TIME")
                        .fontDesign(.serif)
                        .bold()
                    Picker("", selection: $vm.startTimeMode){
                        Text("Start time").tag(true)
                        Text("Finish time").tag(false)
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                }
                Divider()
                DatePicker("",selection: vm.startTimeMode ? $vm.startTime : $vm.finishTime , displayedComponents: .hourAndMinute)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 120, alignment: .center)
                  .compositingGroup()
                  .clipped()
                .datePickerStyle(.wheel)
            }
            .padding(.horizontal, .largeSize)
            .presentationDetents([.small])
        })
     
    }
}

extension PresentationDetent {
    static let bar = Self.custom(BarDetent.self)
    static let small = Self.height(220)
    static let extraLarge = Self.fraction(0.75)
}


private struct BarDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        max(44, context.maxDetentValue * 0.15)
    }
}

