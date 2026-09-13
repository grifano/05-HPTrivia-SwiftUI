//
//  ContentView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 01/09/2026.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State private var audioPlayer: AVAudioPlayer!
    @State private var animatedViewIn = false
    @State private var startGame = false // Why if I use @Binding in other ButtonsView, but in ContentView it @State and no a @Binding too?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AnimatedBackgroundView(geo: geo)
                
                VStack {
                    MainTitleView(animatedViewIn: $animatedViewIn)
                    
                    Spacer()
                    
                    RecentScoreView(animatedViewIn: $animatedViewIn)
                    
                    Spacer()
                    
                    ButtonsBarView(animatedViewIn: $animatedViewIn, startGame: $startGame, geo: geo)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animatedViewIn = true
            playAudio()
        }
        .fullScreenCover(isPresented: $startGame) {
            GameplayView()
                .onAppear() {
                    audioPlayer.setVolume(0, fadeDuration: 2)
                }
                .onDisappear() {
                    audioPlayer.setVolume(1, fadeDuration: 3)
                }
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}
//
//#Preview {
//    ContentView()
//}
