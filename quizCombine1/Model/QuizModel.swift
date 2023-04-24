//
//  QuizModel.swift
//  quizCombine1
//
//  Created by 橋元雄太郎 on 2023/04/22.
//

import SwiftUI

class QuizModel: ObservableObject {
    var questions: [QuizQuestion] = [
        QuizQuestion(question: "アインシュタインが提唱した有名な理論は何ですか？",
                 options: ["量子力学", "一般相対性理論", "進化論", "プラトン主義"],
                 correctAnswerIndex: 1),
        QuizQuestion(question: "日本の首都はどこですか？",
                 options: ["大阪", "京都", "東京", "名古屋"],
                 correctAnswerIndex: 2),
        QuizQuestion(question: "光速はおおよそ何キロメートル/秒ですか？",
                 options: ["3,000", "300,000", "30,000", "3,000,000"],
                 correctAnswerIndex: 1),
        QuizQuestion(question: "太陽が太陽系で最も大きな天体である割合は何パーセントですか？",
                 options: ["99.8%", "98.6%", "95%", "90%"],
                 correctAnswerIndex: 0),
        QuizQuestion(question: "有名なイタリア料理で、トマトソースとチーズがトッピングされたものは何ですか？",
                 options: ["パスタ", "ピザ", "リゾット", "ラザニア"],
                 correctAnswerIndex: 1)
    ]
}