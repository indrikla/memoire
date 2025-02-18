//
//  QuestionModel.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftData
import SwiftUI

@Model
class Question {
    @Attribute(.unique) var id: UUID
    var questionType: QuestionType
    var questionText: String
    var answers: [String]
    var correctAnswerIndex: Int
    var imageData: Data?

    init(questionType: QuestionType, questionText: String, answers: [String], correctAnswerIndex: Int, image: UIImage? = nil) {
        self.id = UUID()
        self.questionType = questionType
        self.questionText = questionText
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        self.imageData = image?.jpegData(compressionQuality: 0.8)
    }
}

enum QuestionType: String, Codable, CaseIterable {
    case WHO = "Who"
    case WHERE = "Where"
    case WHAT = "What"
}
