//
//  SelectBookView.swift
//  05-HPTrivia
//
//  Created by sorlenko on 06/09/2026.
//

import SwiftUI

struct SelectBookView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Game.self) private var game
    
    @State private var showPurchaseAllert = false
    
    var activeBook: Bool {
        for book in game.booksWithQuestions.books {
            if book.status == .active {
                return true
            }
        }
        
        return false
    }
    
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
                                ActiveBook(book: book)
                                .onTapGesture {
                                    withAnimation {
                                        game.booksWithQuestions.setStatus(for: book.id, to: .inactive)
                                    }
                                }
                            case .inactive:
                                InactiveBook(book: book)
                                .onTapGesture {
                                    withAnimation {
                                        game.booksWithQuestions.setStatus(for: book.id, to: .active)
                                    }
                                }
                            default:
                                LockedBook(book: book)
                                .onTapGesture {
                                    withAnimation {
                                        game.booksWithQuestions.setStatus(for: book.id, to: .inactive)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .font(.title2)
                .padding(.bottom, 40)
                
                if !activeBook {
                    Text("You need select at least one book")
                        .multilineTextAlignment(.center)
                }
                
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
                .disabled(!activeBook)
            }
            .padding(20)
        }
        .interactiveDismissDisabled(!activeBook)
    }
}

#Preview {
    SelectBookView()
        .environment(Game())
}
