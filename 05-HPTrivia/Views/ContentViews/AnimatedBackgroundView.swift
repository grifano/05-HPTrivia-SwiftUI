//
//  AnimatedBackgroundView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct AnimatedBackgroundView: View {
    
    let geo: GeometryProxy
    
    var body: some View {
        Image(.hogwarts)
            .resizable()
            .frame(width: geo.size.width * 3, height: geo.size.height)
            .padding(.top, 8)
            .phaseAnimator([false, true]) { content, phase in
                content
                    .offset(x: phase ? geo.size.width / 1.1 : -geo.size.width / 1.1)
            } animation: { _ in
                    .smooth(duration: 60)
            }
    }
}

#Preview {
    GeometryReader { geo in
        AnimatedBackgroundView(geo: geo)
    }
}
