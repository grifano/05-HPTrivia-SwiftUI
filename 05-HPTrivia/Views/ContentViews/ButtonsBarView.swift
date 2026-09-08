//
//  ButtonsBarView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct ButtonsBarView: View {
    
    @Binding var animatedViewIn: Bool
    @Binding var startGame: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        HStack {
            Spacer()
            
            ButtonInstruction(animatedViewIn: $animatedViewIn, geo: geo)
            
            Spacer()
            
            ButtonPlay(animatedViewIn: $animatedViewIn, startGame: $startGame, geo: geo)
            
            Spacer()
            
            ButtonSettings(animatedViewIn: $animatedViewIn, geo: geo)
            
            Spacer()
        }
        .frame(width: geo.size.width)
    }
}

#Preview {
    GeometryReader {geo in
        ButtonsBarView(animatedViewIn: .constant(true), startGame: .constant(false), geo: geo)
    }
}
