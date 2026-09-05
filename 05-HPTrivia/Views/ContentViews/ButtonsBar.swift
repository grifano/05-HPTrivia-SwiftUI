//
//  ButtonsBar.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct ButtonsBar: View {
    
    @Binding var animatedViewIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        HStack {
            Spacer()
            
            ButtonInstruction(animatedViewIn: $animatedViewIn, geo: geo)
            
            Spacer()
            
            ButtonPlay(animatedViewIn: $animatedViewIn, geo: geo)
            
            Spacer()
            
            ButtonSettings(animatedViewIn: $animatedViewIn, geo: geo)
            
            Spacer()
        }
        .frame(width: geo.size.width)
    }
}

#Preview {
    GeometryReader {geo in
        ButtonsBar(animatedViewIn: .constant(true), geo: geo)
    }
}
