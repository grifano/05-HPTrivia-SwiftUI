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
    
    private var store = Store()
    
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
                    .foregroundStyle(.black)
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(game.booksWithQuestions.books) {book in
                            
                            if book.status == .active || (book.status == .locked && store.purchased.contains(book.image)) {
                                ActiveBook(book: book)
                                    .task {
                                        withAnimation {
                                            game.booksWithQuestions.setStatus(for: book.id, to: .active)
                                        }
                                    }
                                .onTapGesture {
                                    withAnimation {
                                        game.booksWithQuestions.setStatus(for: book.id, to: .inactive)
                                    }
                                }
                            } else if book.status == .inactive {
                                InactiveBook(book: book)
                                .onTapGesture {
                                    withAnimation {
                                        game.booksWithQuestions.setStatus(for: book.id, to: .active)
                                    }
                                }
                            } else {
                                LockedBook(book: book)
                                .onTapGesture {
                                    let product = store.products[book.id-4]
                                    
                                    Task {
                                        await store.purchase(product)
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
                        .foregroundStyle(.black)
                }
                
                Button {
                    game.booksWithQuestions.saveStatuses()
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
        .interactiveDismissDisabled()
        .task {
            await store.loadProducts()
        }
    }
}

#Preview {
    SelectBookView()
        .environment(Game())
}
