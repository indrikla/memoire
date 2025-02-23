//
//  HowToPlayModel.swift
//  Memoire
//
//  Created by Risa on 23/02/25.
//

import SwiftUI

struct ContentSection: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let items: [GuidelineItem]?
}

struct GuidelineItem: Codable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case title, description
    }
}

