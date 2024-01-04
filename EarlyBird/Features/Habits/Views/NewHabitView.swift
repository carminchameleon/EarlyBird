//
//  NewHabitView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 4/1/2024.
//

import SwiftUI

struct NewHabitView: View {
    @State var showAdjust = false
    @State var startTimeMode = false
    @State var standardTime = Date.now
    

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
                            Text("6:00")
                                .font(.system(size: 70))
                                .fontDesign(.serif)
                                .bold()
                            Text("Waking Up")
                                .font(.headline)
                        }.overlay(alignment: .top) {
                            ArcShape(startAngle: .degrees(0), endAngle: .degrees(180))
                                .stroke(Theme.subText, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                .frame(width: 280, height: 280)
                                .padding(.top, -40)
                        }
                        
                        Divider()
                        
                        VStack(spacing: .smallSize) {
                            Text("Morning Routine")
                                .bold()
                            Text("for 140 mins")
                                .foregroundColor(.accentColor)
                        }.font(.title3)
                            .fontDesign(.serif)
                        
                        Text("Start work 8:00 am")
                            .font(.callout)
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
        }.sheet(isPresented: $showAdjust, content: {
            VStack (alignment: .center, spacing: 20) {
                HStack(spacing: 20) {
                    Text("STANDARD OF TIME")
                        .fontDesign(.serif)
                        .bold()
                    Picker("", selection: $startTimeMode){
                        Text("Start time").tag(true)
                        Text("Finish time").tag(false)
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                }
                Divider()
                DatePicker("",selection: $standardTime, displayedComponents: .hourAndMinute)
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

#Preview {
    NewHabitView()
}

struct ArcShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the center of the circle
        let center = CGPoint(x: rect.midX, y: rect.midY)
        // Define the radius based on the rect
        let radius = min(rect.width, rect.height) / 2
        
        // Create the arc
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
}
