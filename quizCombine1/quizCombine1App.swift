//
//  quizCombine1App.swift
//  quizCombine1
//
//  Created by 橋元雄太郎 on 2023/04/22.
//

import SwiftUI

@main
struct quizCombine1App: App {
    var body: some Scene {
        WindowGroup {
            let quizModel = QuizModel()
            let quizViewModel = QuizViewModel()
            QuizView()
                .environmentObject(quizModel)
                .environmentObject(quizViewModel)
        }
    }
}
