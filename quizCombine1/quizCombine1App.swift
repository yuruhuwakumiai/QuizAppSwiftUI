//
//  quizCombine1App.swift
//  quizCombine1
//
//  Created by 橋元雄太郎 on 2023/04/22.
//

import SwiftUI

@main
struct QuizApp: App {
    @StateObject private var quizModel = QuizModel()
    @StateObject private var quizViewModel = QuizViewModel()

    var body: some Scene {
        WindowGroup {
            QuizView()
                .environmentObject(quizModel)
                .environmentObject(quizViewModel)
        }
    }
}
