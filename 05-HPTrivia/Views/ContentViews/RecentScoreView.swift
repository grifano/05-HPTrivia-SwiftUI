//
//  RecentScoreView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct RecentScoreView: View {
    @Environment(Game.self) private var game
    @Binding var animatedViewIn: Bool
    
    var body: some View {
        VStack {
            if animatedViewIn {
                VStack {
                    Text("Latest score:")
                        .font(.title2)
                    
                    Text("\(game.recentScores[0])")
                    Text("\(game.recentScores[1])")
                    Text("\(game.recentScores[2])")
                }
                .foregroundStyle(.white)
                .font(.title3)
                .padding(.vertical, 12)
                .padding(.horizontal, 42)
                .background(.black.opacity(0.6))
                .clipShape(.rect(cornerRadius: 30))
                .transition(.opacity)
            }
        }
        .animation(.smooth(duration: 1.2).delay(1.2), value: animatedViewIn)
    }
}

#Preview {
    RecentScoreView(animatedViewIn: .constant(true))
        .environment(Game())
}
