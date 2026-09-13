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
    @State private var revealBook = false
    @State private var correctQuestionTapped = false
    
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
                        Button {
                            game.endGame()
                            dismiss()
                        } label: {
                         Text("End game")
                                .font(.title2)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 24)
                                .background(.red.mix(with: .black, by: 0.4))
                                .clipShape(.rect(cornerRadius: 12))
                        }
                        
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
                        .animation(.easeOut(duration: 1.2).delay(1.2), value: animatedInView)
                        
                        Spacer()
                        
                        VStack {
                            if animatedInView {
                                Image(systemName: "app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .overlay {
                                     Image(systemName: "book.closed")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                            .foregroundStyle(.black)
                                    }
                                    .padding()
                                    .transition(.offset(x: geo.size.width/2))
                                    .phaseAnimator([false, true]) { content, phase in
                                        content
                                            .rotationEffect(.degrees(phase ? 13 : 17))
                                    } animation: { _ in
                                            .easeInOut(duration: 0.7)
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            revealBook = true
                                        }
                                        game.gameScore -= 1
                                        playFlipSound()
                                    }
                                    .rotation3DEffect(.degrees(revealBook ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealBook ? 5 : 1)
                                    .offset(x: revealBook ? geo.size.width / 2 : 0)
                                    .opacity(revealBook ? 0 : 1)
                                    .overlay {
                                        Image("hp\(game.currentQuestion.book)")
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(revealBook ? 1 : 0)
                                            .scaleEffect(revealBook ? 1 : 1.5)
                                            .clipShape(.rect(cornerRadius: 10))
                                    }
                            }
                        }
                        .animation(.easeOut(duration: 1.2 ).delay(1.2), value: animatedInView)
                    }
                    .padding(20)
                    
                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(game.answers, id: \.self) { answer in
                            VStack {
                                if animatedInView {
                                    if answer == game.currentQuestion.answer {
                                        Button {
                                            correctQuestionTapped = true
                                            playCorrectSound()
                                        } label: {
                                            Text(answer)
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.center)
                                                .padding(8)
                                                .frame(width: geo.size.width / 2.3, height: 90)
                                                .background(correctQuestionTapped ? .green.mix(with: .black, by: 0.4) : .gray)
                                                .clipShape(.rect(cornerRadius: 20))
                                                .transition(.opacity)
                                        }
                                        
                                    } else {
                                        Button {
                                            game.gameScore -= 1
                                            playWrongSound()
                                        } label: {
                                            Text(answer)
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.center)
                                                .padding(8)
                                                .frame(width: geo.size.width / 2.3, height: 90)
                                                .background(.gray)
                                                .clipShape(.rect(cornerRadius: 20))
                                                .transition(.opacity)
                                        }
                                    }
                                }
                            }
                            .animation(.easeOut(duration: 1).delay(1), value: animatedInView)
                        }
                    }
                    .padding(20)
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
