//
//  QuizView.swift
//  quizCombine1
//
//  Created by 橋元雄太郎 on 2023/04/22.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizModel: QuizModel
    @EnvironmentObject var quizViewModel: QuizViewModel

    var body: some View {
        NavigationView {
            QuestionView()
                .navigationBarHidden(true)
                .environmentObject(quizModel)          // 残しておいた方がいいらしいGPTいわく
                .environmentObject(quizViewModel)
                .background(NavigationLink("", destination: ResultView(), isActive: $quizViewModel.showResult).opacity(0))
        }
    }
}

struct QuestionView: View {
    @EnvironmentObject var quizModel: QuizModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @State private var isButtonDisabled = false

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(quizModel.questions[quizViewModel.currentQuestionIndex].question)
                    .font(.largeTitle)
                    .frame(width: 300, height: 250)
                ForEach(0..<quizModel.questions[quizViewModel.currentQuestionIndex].options.count, id: \.self) { index in
                    Button(action: {
                        isButtonDisabled = true
                        quizViewModel.checkAnswer(index, quizModel: quizModel)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            quizViewModel.moveToNextQuestion(quizModel: quizModel)
                            isButtonDisabled = false
                        }
                    }) {
                        Text(quizModel.questions[quizViewModel.currentQuestionIndex].options[index])
                            .font(.system(size: 20))
                    }
                    .buttonStyle(AnswerButtonStyle())
                    .disabled(isButtonDisabled)
                }
            }

            if quizViewModel.showAnswerResult {
                Image(quizViewModel.answerResult! ? "checkmark" : "cross")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(quizViewModel.answerResult! ? .green : .red)
                    .opacity(0.7)
                    .animation(.easeInOut(duration: 0.5), value: quizViewModel.showAnswerResult)
            }
        }
    }
}

struct ResultView: View {
    @EnvironmentObject var quizViewModel: QuizViewModel

    var body: some View {
        VStack {
            Text("正解数: \(quizViewModel.correctAnswersCount)")
                .font(.largeTitle)
            Button(action: {
                quizViewModel.resetQuiz()
            }) {
                Text("トップに戻る")
                    .font(.title)
            }
        }
        .navigationBarBackButtonHidden(true) // <- ここを追加
    }
}

struct AnswerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 250, height: 50, alignment: .center)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}
