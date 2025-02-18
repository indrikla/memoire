//
//  DeckListView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI
import SwiftData
import Foundation

struct DeckListView: View {
    @StateObject private var deckViewModel: DeckViewModel = DeckViewModel(dataService: .shared)
    @State private var currentPage = 0
    private let itemsPerPage = 6
    
    private let columns = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]
    
    private var paginatedDecks: [Deck] {
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, deckViewModel.decks.count)
        return Array(deckViewModel.decks[startIndex..<endIndex])
    }
    
    private var totalPages: Int {
        max(1, (deckViewModel.decks.count + itemsPerPage - 1) / itemsPerPage)
    }

    private func previousPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }

    private func nextPage() {
        if currentPage < totalPages - 1 {
            currentPage += 1
        }
    }

    var body: some View {
        ZStack{
            Image("HomeBackground")
                .resizable()
                .scaledToFill()
            HStack {
                Button(action: previousPage) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                        .padding()
                }
                .frame(width: 80, height: 80)
                .background(AppColors.orange1)
                .clipShape(Circle())
                .opacity(currentPage > 0 ? 1 : 0)
                
                VStack(spacing: 36) {
                    LazyVGrid(columns: columns, spacing: 36) {
                        ForEach(paginatedDecks, id: \.id) { deck in
                            DeckComponent(
                                title: deck.title,
                                image: deck.imagePreview != nil ? UIImage(data: deck.imagePreview!) : nil
                            )
                        }
                        if paginatedDecks.count < itemsPerPage {
                            let emptySlots = itemsPerPage - paginatedDecks.count
                            ForEach(0..<emptySlots, id: \.self) { _ in
                                Button(action: {}) {
                                    EmptyCardComponent()
                                }
                            }
                        }
                    }
                }
                .frame(width: 920)
                .padding(.horizontal, 20)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -100 {
                                nextPage()
                            } else if value.translation.width > 100 {
                                previousPage()
                            }
                        }
                )
                
                Button(action: nextPage) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                        .padding()
                }
                .frame(width: 80, height: 80)
                .background(AppColors.orange1)
                .clipShape(Circle())
                .opacity(currentPage < totalPages - 1 ? 1 : 0)
            }
        }
    }
}

#Preview {
    DeckListView()
}
