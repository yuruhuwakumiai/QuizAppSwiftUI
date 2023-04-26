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
    @Published var answerResults: [Bool?] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var quizQuestions: [QuizQuestion] = []
    private let quizDataManager = QuizDataManager()

    func loadQuizQuestions() {
        quizDataManager.fetchQuizQuestions { [weak self] questions in
            DispatchQueue.main.async {
                self?.quizQuestions = questions
            }
        }
    }

    init() {
        $showResult
            .filter { $0 }
            .sink { _ in
                print("Quiz complete!") // showResultがtrueになったら発動 Reslutに遷移したら
            }
            .store(in: &cancellables)
    }

    func checkAnswer(_ answerIndex: Int, quizModel: QuizModel) {
        answerResult = (answerIndex == quizModel.questions[currentQuestionIndex].correctAnswerIndex)
        showAnswerResult = true
        if answerResult! {
            correctAnswersCount += 1
        }
        answerResults.append(answerResult)
    }

    func selectAnswer(_ answerIndex: Int, quizModel: QuizModel) {
        checkAnswer(answerIndex, quizModel: quizModel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.moveToNextQuestion(quizModel: quizModel)
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

    func prepareForNewQuiz() {
        answerResults = []
    }

    func resetQuiz() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
        showResult = false
        answerResult = nil
        showAnswerResult = false
        prepareForNewQuiz() // ここに移動してください。
    }
}
