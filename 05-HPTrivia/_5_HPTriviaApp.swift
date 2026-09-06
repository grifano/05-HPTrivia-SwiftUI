//
//  _5_HPTriviaApp.swift
//  05-HPTrivia
//
//  Created by sorlenko on 01/09/2026.
//

import SwiftUI

@main
struct _5_HPTriviaApp: App {
    private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game)
        }
    }
}

