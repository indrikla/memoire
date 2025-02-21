//
//  SwiftDataService.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftData
import SwiftUI

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Deck.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }

    func fetchDecks() -> [Deck] {
        do {
            let decks = try modelContext.fetch(FetchDescriptor<Deck>())
                print("✅ Fetched Decks: \(decks.count)")
                for deck in decks {
                    print("🔹 Deck Title: \(deck.title)")
                    print("   - 🖼 Image Data Exists: \(deck.imagePreview != nil ? "Yes" : "No")")
                    print("   - 🧩 Questions: \(deck.questions.count)")
                    for question in deck.questions {
                        print("      ▫ \(question.questionText) | Type: \(question.questionType.rawValue)")
                    }
                }
                return decks

//            return try modelContext.fetch(FetchDescriptor<Deck>())
        } catch {
            fatalError("Failed to fetch decks: \(error.localizedDescription)")
        }
    }

    func addDeck(_ deck: Deck) {
        modelContext.insert(deck)
        saveContext()
    }

    func deleteDeck(_ deck: Deck) {
        modelContext.delete(deck)
        saveContext()
    }
    
    func addImagePreview(_ deck: Deck, image: UIImage?) {
        deck.imagePreview = image?.jpegData(compressionQuality: 0.8)
        print("masuk sini untuk \(deck.title)")
        saveContext()
    }


    func addQuestion(to deck: Deck, question: Question) {
        deck.questions.append(question)
        saveContext()
    }

    func deleteQuestion(from deck: Deck, question: Question) {
        deck.questions.removeAll { $0.id == question.id }
        saveContext()
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save changes: \(error.localizedDescription)")
        }
    }

}
