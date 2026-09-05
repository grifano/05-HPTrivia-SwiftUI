//
//  RecentScore.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct RecentScore: View {
    @Binding var animatedViewIn: Bool
    
    var body: some View {
        VStack {
            if animatedViewIn {
                VStack {
                    Text("Latest score:")
                        .font(.title2)
                    
                    Text("33")
                    Text("27")
                    Text("15")
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
    RecentScore(animatedViewIn: .constant(true))
}
