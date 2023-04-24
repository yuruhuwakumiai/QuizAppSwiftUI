//
//  QuizViewModel.swift
//  quizCombine1
//
//  Created by 橋元雄太郎 on 2023/04/22.
//
import SwiftUI
import Combine

class QuizViewModel: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var showAnswerResult = false
    @Published var answerResult: Bool? = nil
    @Published var correctAnswersCount = 0
    @Published var showResult = false
    private var cancellables: Set<AnyCancellable> = []

    init() {
        $showResult
            .filter { $0 }
            .sink { _ in
                print("Quiz complete!")
            }
            .store(in: &cancellables)
    }

    func checkAnswer(_ answerIndex: Int, quizModel: QuizModel) {
        answerResult = (answerIndex == quizModel.questions[currentQuestionIndex].correctAnswerIndex)
        showAnswerResult = true
        if answerResult! {
            correctAnswersCount += 1
        }
    }

    func moveToNextQuestion(quizModel: QuizModel) {
        if currentQuestionIndex < quizModel.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResult = true
        }
        showAnswerResult = false
    }

    func resetQuiz() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
        showResult = false
        answerResult = nil
        showAnswerResult = false
    }
}
