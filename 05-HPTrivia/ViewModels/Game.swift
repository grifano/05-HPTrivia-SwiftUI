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
    let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "RecentScores")
    
    init() {
        loadScores()
    }
    
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
        // Check if user answer all active questions
        if answeredQuestions.count == activeQuestions.count {
            answeredQuestions = []
        }
        
        // Get a current question
        currentQuestion = activeQuestions.randomElement()!
        
        while(answeredQuestions.contains(currentQuestion.id)) {
            // Get a random active question till not answered
            currentQuestion = activeQuestions.randomElement()!
        }
        
        // Collect answers collection
        answers = []
        answers.append(currentQuestion.answer)
        for wrongAnswer in currentQuestion.wrong {
            answers.append(wrongAnswer)
        }
        answers.shuffle()
        
        // Setup a score system
        questionScore = 5
    }
    
    func correct() {
        answeredQuestions.append(currentQuestion.id)
        withAnimation {
            gameScore += questionScore
        }
    }
    
    func endGame() {
        recentScores[2] = recentScores[1]
        recentScores[1] = recentScores[0]
        recentScores[0] = gameScore
        saveScores()
        
        gameScore = 0
        
        activeQuestions = []
        answeredQuestions = []
    }
    
    func saveScores() {
        do {
            let data = try JSONEncoder().encode(recentScores)
            try data.write(to: savePath)
        } catch {
            print("Unable to save score: \(error)")
        }
    }
    
    func loadScores() {
        do {
            let data = try Data(contentsOf: savePath)
            recentScores = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            recentScores = [0, 0, 0]
        }
    }
}
