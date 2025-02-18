//
//  DeckViewModel.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftData
import SwiftUI
import Foundation

class DeckViewModel: ObservableObject {
    @Published var decks: [Deck] = []
    
    private let dataService: SwiftDataService

    init(dataService: SwiftDataService) {
        self.dataService = dataService
//        let dummyDeck = Deck.dummyDecks
//            for deck in dummyDeck {
//                dataService.addDeck(deck)
//            }
        fetchDecks()
        
    }

    func fetchDecks() {
        decks = dataService.fetchDecks()
    }

    func addDeck(title: String, image: UIImage?, questions: [Question]) {
        let newDeck = Deck(title: title, image: image, questions: questions)
        dataService.addDeck(newDeck)
        fetchDecks()
    }

    func deleteDeck(_ deck: Deck) {
        dataService.deleteDeck(deck)
        fetchDecks()
    }
}

extension Deck {
    static let dummyDecks: [Deck] = [
        Deck(title: "Family Memories", image: UIImage(named: "Image"), questions: [
            Question(
                questionType: .WHO,
                questionText: "Who is in this photo?",
                answers: ["Mom", "Dad", "Uncle", "Grandfather"],
                correctAnswerIndex: 0,
                image: UIImage(named: "family_photo")
            ),
            Question(
                questionType: .WHERE,
                questionText: "Where was this picture taken?",
                answers: ["Home", "Beach", "Park", "School"],
                correctAnswerIndex: 1,
                image: UIImage(named: "beach_memory")
            )
        ]),
        Deck(title: "Vacation Memories", image: nil, questions: [
            Question(
                questionType: .WHO,
                questionText: "Where did you go for your first trip?",
                answers: ["Bali", "Paris", "Tokyo", "New York"],
                correctAnswerIndex: 0,
                image: UIImage(named: "travel_photo")
            )
        ])
    ]
}
