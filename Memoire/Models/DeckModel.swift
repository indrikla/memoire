//
//  DeckModel.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftData
import SwiftUI

@Model
class Deck {
    @Attribute(.unique) var id: UUID
    var title: String
    var imagePreview: Data?
    @Relationship(deleteRule: .cascade) var questions: [Question] = []

    init(title: String, image: UIImage? = nil, questions: [Question]) {
        self.id = UUID()
        self.title = title
        self.imagePreview = image?.jpegData(compressionQuality: 0.8)
        self.questions = []
    }
}
