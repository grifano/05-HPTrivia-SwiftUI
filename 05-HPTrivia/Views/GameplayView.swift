//
//  GameplayView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 07/09/2026.
//

import SwiftUI
import AVKit

struct GameplayView: View {
    @Environment(Game.self) private var game
    @Environment(\.dismiss) private var dismiss
    
    @State private var musicPlayer: AVAudioPlayer!
    @State private var sfxPlayer: AVAudioPlayer!
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    .onAppear() {
                        playMusic()
                    }
                
                VStack {
                    // MARK: Controls
                    
                    // MARK: Question
                    
                    // MARK: Hint
                    
                    // MARK: Answers
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
                // MARK: Celebrations
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear() {
            game.startGame()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                playMusic()
            }
        }
    }
    
    private func playMusic() {
        let sounds = ["deep-in-the-dell", "hiding-place-in-the-forest", "let-the-mystery-unfold", "spellcraft"]
        let song = sounds.randomElement()!
        
        let sound = Bundle.main.path(forResource: song, ofType: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = 0.1
        musicPlayer.play()
    }
    
    private func playCorrectSound() {
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.play()
    }
    
    private func playWrongSound() {
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.play()
    }
    
    private func playFlipSound() {
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.play()
    }
}

#Preview {
    GameplayView()
        .environment(Game())
}
