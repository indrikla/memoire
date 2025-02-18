//
//  QuestionViewModel.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftData
import SwiftUI
import Foundation

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    
    private let dataService: SwiftDataService
    private let deck: Deck

    init(deck: Deck, dataService: SwiftDataService) {
        self.deck = deck
        self.dataService = dataService
        self.questions = deck.questions
    }

    func addQuestion(questionType: QuestionType, questionText: String, answers: [String], correctAnswerIndex: Int, image: UIImage?) {
        let newQuestion = Question(questionType: questionType, questionText: questionText, answers: answers, correctAnswerIndex: correctAnswerIndex, image: image)
        dataService.addQuestion(to: deck, question: newQuestion)
        questions = deck.questions
    }

    func deleteQuestion(_ question: Question) {
        dataService.deleteQuestion(from: deck, question: question)
        questions = deck.questions
    }
}
