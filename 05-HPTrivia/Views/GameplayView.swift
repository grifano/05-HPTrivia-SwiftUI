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
    
    @State private var animatedInView = false
    @State private var revealHint = false
    
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
                
                VStack {
                    // MARK: Controls
                    HStack {
                        Button("End game") {
                            game.endGame()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        .font(.title)
                        
                        Spacer()
                        
                        Text("Score: \(game.gameScore)")
                        
                    }
                    .padding(20)
                    
                    // MARK: Question
                    VStack {
                        if animatedInView {
                            Text(game.currentQuestion.question)
                                .font(.custom("PartyLetPlain", size: 50))
                                .multilineTextAlignment(.center)
                                .transition(.scale)
                        }
                    }
                    .animation(.easeOut(duration: 0.4), value: animatedInView)
                    
                    // MARK: Hint
                    HStack {
                        VStack {
                            if animatedInView {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .padding()
                                    .transition(.offset(x: -geo.size.width/2))
                                    .phaseAnimator([false, true]) { content, phase in
                                        content
                                            .rotationEffect(.degrees(phase ? -13 : -17))
                                    } animation: { _ in
                                            .easeInOut(duration: 0.7)
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            revealHint = true
                                        }
                                        game.gameScore -= 1
                                        playFlipSound()
                                    }
                                    .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .offset(x: revealHint ? geo.size.width / 2 : 0)
                                    .opacity(revealHint ? 0 : 1)
                                    .overlay {
                                        Text(game.currentQuestion.hint)
                                            .padding(.leading, 20)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .opacity(revealHint ? 1 : 0)
                                            .scaleEffect(revealHint ? 1.33 : 1)
                                    }
                            }
                        }
                        .animation(.easeOut(duration: 1.5 ).delay(2), value: animatedInView)
                        
                        Spacer()
                    }
                    .padding(20)
                    
                    
                    // MARK: Answers
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
                // MARK: Celebrations
            }
            .foregroundStyle(.white)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear() {
            game.startGame()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animatedInView = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
        //        musicPlayer.play()
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
