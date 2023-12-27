//
//  DebounceTextField.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 26/12/2023.
//

import SwiftUI
import Combine

struct DebounceTextField: View {
  
  @State var publisher = PassthroughSubject<String, Never>()
  
  @State var label: String
  @Binding var value: String
  var valueChanged: ((_ value: String) -> Void)?
  
    @State var debounceSeconds = 0.5
  
  var body: some View {
    TextField(label, text: $value,  axis: .vertical)
      .font(.title3)
      .bold()
      .minimumScaleFactor(0.5)
      .lineLimit(1)
      .layoutPriority(1)
      .padding(.horizontal)
      
      .frame(height: 55)
      .background(Color(UIColor.secondarySystemBackground))
      .cornerRadius(.mediumSize)
      .disableAutocorrection(true)
      .onChange(of: value) { value in
        publisher.send(value)
      }
      .onReceive(
        publisher.debounce(
          for: .seconds(debounceSeconds),
          scheduler: DispatchQueue.main
        )
      ) { value in
        if let valueChanged = valueChanged {
          valueChanged(value)
        }
      }
  }
}

#Preview {
    DebounceTextField(label: "placeholder", value: .constant("routine title"))
}
