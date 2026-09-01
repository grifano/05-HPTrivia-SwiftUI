//
//  Question.swift
//  05-HPTrivia
//
//  Created by sorlenko on 01/09/2026.
//

struct Question: Decodable {
    let id: Int
    let question: String
    let answer: String
    let wrong: [String]
    let book: Int
    let hint: String
}
