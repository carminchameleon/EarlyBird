//
//  AddRoutineView1.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/12/2023.
//

import SwiftUI

struct AddRoutineView1: View {
    @Binding var isShowingSheet: Bool
    @State var textFieldValue: String = "" {
        didSet {
            print(textFieldValue)
        }
    }
    @State var selectedColor: UIColor?
    @State private var text: String = ""
    @State private var emoji: String = "" {
        didSet {
            
        }
    }
    
    func getLastLetter(emoji: String) -> String {
        var result = ""
        if let lastOne = emoji.last {
            result = String(lastOne)
        }
        return result
    }
    
    @State var hour: Int = 00
    @State var min: Int = 00 {
        didSet {
            print(min)
        }
    }
    @State var sec: Int = 00
    
    @FocusState var isKeyboardVisible: Bool
    
    
    var firstColorList = [UIColor.systemRed, UIColor.systemOrange, UIColor.systemYellow, UIColor.systemGreen, UIColor.systemTeal, UIColor.systemBlue, UIColor.systemIndigo, UIColor.systemPink, UIColor.purple, UIColor.systemCyan, UIColor.systemGray, UIColor.systemBrown]
    
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 20, maximum: 400)), count: 4)

    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                GroupBox {
                    VStack(spacing: .largeSize){
                        Circle()
                            .fill(.blue.gradient)
                            .frame(width:80)
                            .overlay {
                                Text(getLastLetter(emoji: emoji))
                            }
                        HStack {
                            TextField(text: $emoji) {
                            }
                            .lineLimit(1)
                            .onChange(of: emoji, {
                                isKeyboardVisible = false
                            })
                            .frame(width: 0, height: 0)
                            .focused($isKeyboardVisible)
                            Button(action: {
                                isKeyboardVisible = true
                            }, label: {
                                Text("😃")
                                    .font(.largeTitle)
                                    .overlay(alignment:.center) {
                                        Circle()
                                            .fill(Color(UIColor.systemGray).opacity(0.4))
                                    }
                            })
                            
                            .buttonStyle(.bordered)
                            .frame(height: 55)
                            TextField("Routine Name", text: $textFieldValue)
                                .fontDesign(.rounded)
                                .font(.title3)
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .frame(height: 55)
                                .background(Color(UIColor.tertiarySystemFill))
                                .cornerRadius(.mediumSize)
                        }
                    }
                    
                    GroupBox{
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 16){
                            ForEach(firstColorList, id: \.self.cgColor) { color in
                                Circle()
                                    .strokeBorder()
                                    .fill(Color(color).gradient)
                            }
                        }
                    }
                    
                    GroupBox {
                        CustomTimePickers(hour: $hour, min: $min, sec: $sec)
                    }
                    
                    .navigationTitle("New Routine")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                isShowingSheet.toggle()
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                isShowingSheet.toggle()
                            }, label: {
                                Text("Done")
                            })
                            .disabled(true)
                        }
                    }
                }
            }.onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    self.isKeyboardVisible = true
                }
            }
        }
    }
}

#Preview {
    AddRoutineView1(isShowingSheet: .constant(true))
}


