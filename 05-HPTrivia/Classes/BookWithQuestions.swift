//
//  BookWithQuestions.swift
//  05-HPTrivia
//
//  Created by sorlenko on 06/09/2026.
//

import Foundation

@Observable
 class BookWithQuestions {
    var books: [Book] = []
     
     init() {
         // Decode questions and collect them to array
         let decodedQuestions = getDecodeQuestions()
         
         // Organize questions by books
         let organizedQuestions = getOrganizedQuestions(decodedQuestions)
         
         // Populate books based on index questions array
         createBooks(with: organizedQuestions)
     }
     
     private func getDecodeQuestions() -> [Question] {
         var decodedQuestions: [Question] = []
         
         if let url = Bundle.main.url(forResource: "trivia", withExtension: "json") {
             do {
                 let data = try Data(contentsOf: url)
                 decodedQuestions = try JSONDecoder().decode([Question].self, from: data)
             } catch {
                 print("Error from questions JSON decoder: \(error) ")
             }
         }
         
         return decodedQuestions
     }
     
     private func getOrganizedQuestions(_ questions: [Question]) -> [[Question]] {
         var organizedQuestions: [[Question]] = [[], [], [], [], [], [], [], []]
         
         for question in questions {
             organizedQuestions[question.book].append(question)
         }
         
         return organizedQuestions
     }
     
     private func createBooks(with questions: [[Question]]) {
         books.append(Book(id: 1, image: "hp1", questions: questions[1], status: .active))
         books.append(Book(id: 2, image: "hp2", questions: questions[2], status: .active))
         books.append(Book(id: 3, image: "hp3", questions: questions[3], status: .inactive))
         books.append(Book(id: 4, image: "hp4", questions: questions[4], status: .locked))
         books.append(Book(id: 5, image: "hp5", questions: questions[5], status: .locked))
         books.append(Book(id: 6, image: "hp6", questions: questions[6], status: .locked))
         books.append(Book(id: 7, image: "hp7", questions: questions[7], status: .locked))
     }
     
     func setStatus(for id: Int, to status: BookStatus) {
         books[id-1].status = status
     }
}
