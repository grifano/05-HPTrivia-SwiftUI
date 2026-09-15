//
//  Book.swift
//  05-HPTrivia
//
//  Created by sorlenko on 06/09/2026.
//

struct Book: Identifiable, Codable {
    let id: Int
    let image: String
    let questions: [Question]
    var status: BookStatus
}

enum BookStatus: Codable {
    case active, inactive, locked
}
