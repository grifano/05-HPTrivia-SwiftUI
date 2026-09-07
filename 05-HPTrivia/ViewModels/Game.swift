//
//  Game.swift
//  05-HPTrivia
//
//  Created by sorlenko on 06/09/2026.
//

import SwiftUI

@Observable
class Game {
    let booksWithQuestions = BookWithQuestions()
    
    var gameScore = 0
    var questionScore = 5
    var recentScores = [0, 0 ,0]
    
    var activeQuestions: [Question] = []
    var answeredQuestions: [Int] = []
    var currentQuestion: Question = try! JSONDecoder().decode(
        [Question].self,
        from: Data(contentsOf:Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
    var answers: [String] = []
    
    func startGame() {
        for book in booksWithQuestions.books {
            if book.status == .active {
                for question in book.questions {
                    activeQuestions.append(question)
                }
            }
        }
        
        newQuestion()
    }
    
    func newQuestion() {
        
    }
    
    func correct() {
        
    }
    
    func endGame() {
        recentScores[2] = recentScores[1]
        recentScores[1] = recentScores[0]
        recentScores[0] = gameScore
        
        gameScore = 0
        
        activeQuestions = []
        answeredQuestions = []
    }
}
