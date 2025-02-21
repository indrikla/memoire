//
//  CardRevealComponent.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftUI

struct CardRevealComponent: View {
    @Binding var flippedCards: Set<String>

    let rows = 3
    let cols = 3

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<cols, id: \.self) { col in
                        let cardID = "\(row)-\(col)"
                        CardView(isFlipped: flippedCards.contains(cardID))
                            .onTapGesture {
                                flipCard(cardID)
                                print("Card Flipped \(cardID)")
                            }
                    }
                }
            }
        }
    }

    private func flipCard(_ cardID: String) {
        if flippedCards.contains(cardID) { return }
        flippedCards.insert(cardID)
    }
}

#Preview {
    CardRevealComponent(flippedCards: .constant([]))
}
