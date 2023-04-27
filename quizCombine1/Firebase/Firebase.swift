//
//  Firebase.swift
//  quizCombine1
//
//  Created by 橋元雄太郎 on 2023/04/27.
//
import Firebase
import FirebaseDatabase

class QuizDataManager {
    private let database = Database.database().reference()

    func fetchQuizQuestions(completion: @escaping ([QuizQuestion]) -> Void) {
        database.child("questions").observeSingleEvent(of: .value, with: { snapshot in
            var quizQuestions: [QuizQuestion] = []

            if let value = snapshot.value as? [String: Any] {
                for (key, questionData) in value {
                    if let questionDict = questionData as? [String: Any],
                       let question = questionDict["questionText"] as? String,
                       let options = questionDict["options"] as? [String],
                       let correctAnswerIndex = questionDict["correctAnswerIndex"] as? Int {
                        let quizQuestion = QuizQuestion(id: key, question: question, options: options, correctAnswerIndex: correctAnswerIndex)
                        quizQuestions.append(quizQuestion)
                    }
                }
            }
            print(quizQuestions) // データを確認するための出力
            completion(quizQuestions)
        })
    }
}
