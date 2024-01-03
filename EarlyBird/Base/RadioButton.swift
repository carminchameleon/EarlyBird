//
//  RadioButton.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 26/12/2023.
//

import SwiftUI


struct RadioButton: View {
    @Binding var value: Bool
    var isTapped: (Bool) -> Void
    
    var body: some View {
        Button {
            isTapped(value)
        } label: {
            value ? Symbols.radioCheckmark : Symbols.radioCircle
        }
    }
}

#Preview {
    RadioButton(value: .constant(false)) { result in
        
    }
}
