//
//  LazyView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 1/1/2024.
//

import SwiftUI

struct LazyView<ActionDetailView: View>: View {
    var content: () -> ActionDetailView
    
    var body: some View {
        content()
    }
}

