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
    
    private let dataService: SwiftDataService
    
    init(dataService: SwiftDataService) {
        self.dataService = dataService
        fetchDecks()
    }
    
    func fetchDecks() {
        decks = dataService.fetchDecks()
    }
}
