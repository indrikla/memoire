//
//  SystemDeckLoader.swift
//  Memoire
//
//  Created by Risa on 23/02/25.
//

import SwiftUI

class JSONLoader {
    static func loadSystemDeck(byID id: String) -> SystemDeck {
        guard let url = Bundle.main.url(forResource: "SystemDecks", withExtension: "json") else {
            fatalError("JSON file not found")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decks = try decoder.decode([SystemDeck].self, from: data)
            print(decks)

            if let deck = decks.first(where: { $0.id == id }) {
                return deck
            } else {
                fatalError("Deck with ID \(id) not found in JSON")
            }
        } catch {
            fatalError("Failed to load JSON: \(error)")
        }
    }
    
    static func load<T: Decodable>(_ fileName: String) -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("❌ JSON file '\(fileName).json' not found in bundle.")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("❌ Failed to load JSON '\(fileName).json': \(error)")
        }
    }
}
