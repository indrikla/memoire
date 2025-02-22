//
//  SystemDeckModel.swift
//  Memoire
//
//  Created by Risa on 23/02/25.
//

import Foundation

struct SystemDeck: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let image: String
    let questions: [SystemQuestion]
}

struct SystemQuestion: Codable, Identifiable, Hashable{
    var id: String { questionText }
    let questionText: String
    let answers: [String]
    let correctAnswerIndex: Int
    let image: String
    let successQuestion: String
}

