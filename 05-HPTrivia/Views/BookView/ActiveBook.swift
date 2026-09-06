//
//  ActiveBook.swift
//  05-HPTrivia
//
//  Created by sorlenko on 06/09/2026.
//

import SwiftUI

struct ActiveBook: View {
    @State var book: Book
    
    var body: some View {
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
    }
}

#Preview {
    ActiveBook(book: BookWithQuestions().books[0])
}
