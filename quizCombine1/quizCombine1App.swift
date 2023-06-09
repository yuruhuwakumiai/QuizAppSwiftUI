//
//  quizCombine1App.swift
//  quizCombine1
//
//  Created by 橋元雄太郎 on 2023/04/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct QuizApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // firebase

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
