//
//  SelectBook.swift
//  05-HPTrivia
//
//  Created by sorlenko on 06/09/2026.
//

import SwiftUI

struct SelectBook: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Game.self) private var game
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Wich books would you like to see questions from?")
                    .font(.title)
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(game.booksWithQuestions.books) {book in
                            switch book.status {
                            case .active:
                                ZStack(alignment: .bottomTrailing) {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.rect(cornerRadius: 12))
                                        .shadow(color: .black.opacity(0.2), radius: 8)
                                    
                                    Image(systemName: "checkmark.square.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                }
                                .padding(8)
                            case .inactive:
                                ZStack(alignment: .bottomTrailing) {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.rect(cornerRadius: 12))
                                        .shadow(color: .black.opacity(0.2), radius: 8)
                                }
                                .padding(8)
                            default:
                                ZStack(alignment: .bottomTrailing) {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.rect(cornerRadius: 12))
                                        .shadow(color: .black.opacity(0.2), radius: 8)
                                }
                                .padding(8)
                                .saturation(0)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .font(.title2)
                .padding(.bottom, 40)
                
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
            .padding(20)
        }
    }
}

#Preview {
    SelectBook()
        .environment(Game())
}
