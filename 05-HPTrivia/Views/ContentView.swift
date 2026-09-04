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
    @State private var animatedButtonPlay = false
    @State private var showInstructionView = false
    @State private var showSettingsView = false
    @State private var startGame = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
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
                
                VStack {
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
                    
                    Spacer()
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
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        VStack {
                            if animatedViewIn {
                                Button {
                                    showInstructionView.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                }
                                .transition(.offset(x: -geo.size.width / 2))
                            }
                        }
                        .animation(.easeInOut(duration: 1.5).delay(1), value: animatedViewIn)
                        
                        Spacer()
                        
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
                                    .onAppear() {
                                        withAnimation(.easeInOut(duration: 1).repeatForever()) {
                                            animatedButtonPlay.toggle()
                                        }
                                    }
                                }
                                .transition(.offset(y: geo.size.height / 3))
                                
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(0.5), value: animatedViewIn)
                        
                        Spacer()
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
                        
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animatedViewIn = true
            animatedButtonPlay = true
//            playAudio()
        }
        .sheet(isPresented: $showInstructionView) {
            InfoScreenView()
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
}
