//
//  SystemDeckLoader.swift
//  Memoire
//
//  Created by Risa on 23/02/25.
//

import SwiftUI

class SystemDeckLoader {
    static func loadSystemDeck(byID id: String) -> SystemDeck { // ✅ Fetch SystemDeck by ID
        guard let url = Bundle.main.url(forResource: "SystemDecks", withExtension: "json") else {
            fatalError("JSON file not found")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decks = try decoder.decode([SystemDeck].self, from: data)
            print(decks)

            if let deck = decks.first(where: { $0.id == id }) {  // ✅ Find by ID
                return deck  // ✅ Now returning a single SystemDeck
            } else {
                fatalError("Deck with ID \(id) not found in JSON")
            }
        } catch {
            fatalError("Failed to load JSON: \(error)")
        }
    }

}
