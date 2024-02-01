//
//  EmptyActionView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 1/2/2024.
//

import SwiftUI

struct EmptyActionView: View {
    
    var addButtonTapped: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: .extraLargeSize) {
                Text("📢")
                    .font(.system(size: 80))

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
                    addButtonTapped()
                } label: {
                    Text("Add Action")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, .smallSize)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 12))
            }.verticalCenter()
            
          
        }
    }
}

#Preview {
    EmptyActionView() {
        
    }
}
