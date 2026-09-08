//
//  ButtonPlay.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct ButtonPlay: View {
    @State private var animatedButtonPlay = false
    
    @Binding var animatedViewIn: Bool
    @Binding var startGame: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animatedViewIn {
                VStack {
                    Button {
                        startGame.toggle()
                    } label: {
                        Text("Play")
                            .font(.largeTitle)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .buttonStyle(.glassProminent)
                    .buttonSizing(.flexible)
                    .tint(Color(red: 86/255, green: 93/255, blue: 139/255))
                    .frame(maxWidth: 200)
                    .scaleEffect(animatedButtonPlay ? 1.1 : 1)
//                                    .onAppear() {
//                                        withAnimation(.easeInOut(duration: 1).repeatForever()) {
//                                            animatedButtonPlay.toggle()
//                                        }
//                                    }
                }
                .transition(.offset(y: geo.size.height / 3))
                
            }
        }
        .animation(.easeOut(duration: 0.7).delay(0.5), value: animatedViewIn)
        .onAppear {
            animatedButtonPlay = true
        }
    }
}

#Preview {
    GeometryReader { geo in
        ButtonPlay(animatedViewIn: .constant(true), startGame: .constant(false), geo: geo)
    }
}
