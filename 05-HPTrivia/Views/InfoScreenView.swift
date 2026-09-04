//
//  InfoScreenView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 01/09/2026.
//

import SwiftUI

struct InfoScreenView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Image(.appiconwithradius)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                
                ScrollView {
                    Text("How To Play")
                        .font(.largeTitle)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Welcome to HP Trivia! In this game you will be asked random questions from the HP books and you must guess the right answer or you will lose points!😱")
                        
                        Text("Each question is worth 5 points, but if you guess a wrong answer, you lose 1 point.")
                        
                        Text("If you are struggling with a question, there is an option to reveal a hint or reveal the book that answers the question. But beware! Using these also removes 1 point each.")
                        
                        Text("When you select the correct answer, you will be awarded all the points left for that question and they will be added to your total score.")
                    }
                    .padding(.horizontal)
                    
                    Text("Good Luck!")
                        .font(.title)
                        .padding(.top)

                }
                .font(.title2)
                .padding(.vertical, 40)
                
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.largeTitle)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .tint(.brown)
                .frame(maxWidth: 200)
            }
            .padding(.bottom, 40)
        }
    }
}
#Preview {
    InfoScreenView()
}
