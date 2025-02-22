//
//  DeckListViewModel.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftData
import SwiftUI
import Foundation

class DeckListViewModel: ObservableObject {
    @Published var decks: [Deck] = []
    @Published var systemDecks: [SystemDeck] = []
    
    private let dataService: SwiftDataService
    
    init(dataService: SwiftDataService) {
        self.dataService = dataService
        fetchDecks()
    }
    
    func fetchDecks() {
        decks = dataService.fetchDecks()
    }
    
    func doesDeckExist(_ deck: Deck) -> Bool {
        return decks.contains { $0.id == deck.id }
    }

    func deleteDeck(_ deck: Deck) {
        print("\(deck.title) with \(deck.questions) deleted")
        dataService.deleteAllQuestion(from: deck, questions: deck.questions)
        dataService.deleteDeck(deck)
        decks = decks.filter { $0.id != deck.id }
    }
}
