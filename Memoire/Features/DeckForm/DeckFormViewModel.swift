//
//  DeckFormViewModel.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftData
import SwiftUI
import Foundation

class DeckFormViewModel: ObservableObject {
    @Published var deck: Deck = .init(title: "")
    @Published var questions: [Question] = []

    @Published var isQuestionValid: Bool = false
    @Published var canSubmit: Bool = false
    
    private let dataService: SwiftDataService

    init(dataService: SwiftDataService) {
        self.dataService = dataService
    }
    
    func addDeck(title: String, image: UIImage?) -> Deck {
        let newDeck = Deck(title: title, image: image)
        dataService.addDeck(newDeck)
        self.deck = newDeck
        return newDeck
    }

    func deleteDeck(_ deck: Deck) {
        dataService.deleteDeck(deck)
    }
    
    func addImagePreview(_ deck: Deck, image: UIImage?) {
        dataService.addImagePreview(deck, image: image)
    }
    
    func addQuestionToArray(questionType: QuestionType, questionText: String, answers: [String], correctAnswerIndex: Int, image: UIImage?) {
        let newQuestion = Question(
            questionType: questionType,
            questionText: questionText,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            image: image,
            deck: deck
        )
        questions.append(newQuestion)
    }

    func deleteQuestion(_ question: Question) {
        dataService.deleteQuestion(from: deck, question: question)
        questions = deck.questions
    }
    
    func saveQuestionToDeck(deck: Deck, questions: [Question]) {
        for q in questions {
            dataService.addQuestion(to: deck, question: q)
            deck.questions.append(q)
        }
    }
}
