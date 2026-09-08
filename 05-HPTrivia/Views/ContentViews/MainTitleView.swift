//
//  MainTitleView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct MainTitleView: View {
    @Binding var animatedViewIn: Bool
    
    var body: some View {
        VStack {
            if animatedViewIn {
                VStack {
                    Image(systemName: "bolt.fill")
                        .imageScale(.large)
                        .font(.largeTitle)
                    
                    Text("HP")
                        .font(.custom("PartyLetPlain", size: 70))
                        .padding(.bottom, -50)
                    
                    Text("Trivia")
                        .font(.custom("PartyLetPlain", size: 50))
                }
                .padding(.top, 70)
                .transition(.move(edge: .top))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(0.5), value: animatedViewIn)
    }
}

#Preview {
    MainTitleView(animatedViewIn: .constant(true))
}
