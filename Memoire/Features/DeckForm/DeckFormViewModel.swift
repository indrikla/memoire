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

//extension Deck {
//    static func createDummyData() {
//        let dataService = SwiftDataService.shared
//
//        // 🟢 Create Decks First
//        let deck1 = Deck(title: "Family Memories", image: UIImage(named: "family_photo"))
//        let deck2 = Deck(title: "Vacation Memories", image: UIImage(named: "travel_photo"))
//
//        dataService.addDeck(deck1)
//        dataService.addDeck(deck2)
//
//        // 🟢 Now Create Questions & Assign to Decks
//        let questionsForDeck1 = [
//            Question(
//                questionType: .WHO,
//                questionText: "Who is in this photo?",
//                answers: ["Mom", "Dad", "Uncle", "Grandfather"],
//                correctAnswerIndex: 0,
//                image: UIImage(named: "family_photo"),
//                deck: deck1 // ✅ Assign to Deck
//            ),
//            Question(
//                questionType: .WHERE,
//                questionText: "Where was this picture taken?",
//                answers: ["Home", "Beach", "Park", "School"],
//                correctAnswerIndex: 1,
//                image: UIImage(named: "beach_memory"),
//                deck: deck1
//            )
//        ]
//
//        let questionsForDeck2 = [
//            Question(
//                questionType: .WHERE,
//                questionText: "Where did you go for your first trip?",
//                answers: ["Bali", "Paris", "Tokyo", "New York"],
//                correctAnswerIndex: 0,
//                image: UIImage(named: "travel_photo"),
//                deck: deck2
//            )
//        ]
//
//        // 🟢 Add questions to SwiftData
//        for question in questionsForDeck1 {
//            dataService.addQuestion(to: deck1, question: question)
//        }
//        for question in questionsForDeck2 {
//            dataService.addQuestion(to: deck2, question: question)
//        }
//    }
//}


//extension Deck {
//    static let dummyDecks: [Deck] = [
//        Deck(title: "Family Memories", image: UIImage(named: "Image"), questions: [
//            Question(
//                questionType: .WHO,
//                questionText: "Who is in this photo?",
//                answers: ["Mom", "Dad", "Uncle", "Grandfather"],
//                correctAnswerIndex: 0,
//                image: UIImage(named: "family_photo")
//            ),
//            Question(
//                questionType: .WHERE,
//                questionText: "Where was this picture taken?",
//                answers: ["Home", "Beach", "Park", "School"],
//                correctAnswerIndex: 1,
//                image: UIImage(named: "beach_memory")
//            )
//        ]),
//        Deck(title: "Vacation Memories", image: nil, questions: [
//            Question(
//                questionType: .WHO,
//                questionText: "Where did you go for your first trip?",
//                answers: ["Bali", "Paris", "Tokyo", "New York"],
//                correctAnswerIndex: 0,
//                image: UIImage(named: "travel_photo")
//            )
//        ])
//    ]
//}
