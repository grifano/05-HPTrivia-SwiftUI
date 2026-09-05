//
//  ButtonInstruction.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct ButtonInstruction: View {
    @State private var showInstructionView = false
    
    @Binding var animatedViewIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animatedViewIn {
                Button {
                    showInstructionView.toggle()
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
                .transition(.offset(x: -geo.size.width / 2))
            }
        }
        .animation(.easeInOut(duration: 1.5).delay(1), value: animatedViewIn)
        .sheet(isPresented: $showInstructionView) {
            InfoScreenView()
        }
    }
}

#Preview {
    GeometryReader {geo in
        ButtonInstruction(animatedViewIn: .constant(true), geo: geo)
    }
}
