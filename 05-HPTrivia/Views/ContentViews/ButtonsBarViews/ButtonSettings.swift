//
//  ButtonSettings.swift
//  05-HPTrivia
//
//  Created by sorlenko on 05/09/2026.
//

import SwiftUI

struct ButtonSettings: View {
    @State private var showSettingsView = false
    
    @Binding var animatedViewIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animatedViewIn {
                Button {
                    showSettingsView.toggle()
                } label: {
                    Image(systemName: "gear.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
                .transition(.offset(x: geo.size.width / 2))
            }
        }
        .animation(.easeInOut(duration: 1.5).delay(1), value: animatedViewIn)
        .sheet(isPresented: $showSettingsView) {
            SettingsScreenView()
        }
    }
}

#Preview {
    GeometryReader { geo in
        ButtonSettings(animatedViewIn: .constant(true), geo: geo)
    }
}
