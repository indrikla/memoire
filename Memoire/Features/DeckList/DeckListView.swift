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
    @StateObject var deckListViewModel = DeckListViewModel(dataService: .shared)
    @State private var currentPage = 0
    @State private var isAddDeckPopUpVisible = false
    @EnvironmentObject private var router: Router

    private let itemsPerPage = 6
    private let columns = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]

    /// Sorted decks before pagination
    private var sortedDecks: [Deck] {
        deckListViewModel.decks.sorted { $0.id.uuidString < $1.id.uuidString } // ✅ Sort by id (ascending)
    }

    private var totalDecks: Int {
        sortedDecks.count
    }

    private var totalPages: Int {
        let fullPages = (totalDecks / itemsPerPage)
        let hasExtraPage = totalDecks % itemsPerPage > 0
        return fullPages + (hasExtraPage ? 1 : 0) // ✅ Fixes extra page issue
    }

    /// Returns the decks for the current page after sorting
    private var paginatedDecks: [Deck] {
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, totalDecks)

        if currentPage == totalPages - 1 && totalDecks % itemsPerPage == 0 {
            return []
        }
        return Array(sortedDecks[startIndex..<endIndex])
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
        ZStack {
            Image("HomeBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

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
                        if !paginatedDecks.isEmpty {
                            ForEach(paginatedDecks, id: \.id) { deck in
                                Button(action: {
                                    router.navigate(to: .gameplay(deck: deck))
                                }) {
                                    DeckComponent(
                                        title: deck.title,
                                        image: deck.imagePreview != nil ? UIImage(data: deck.imagePreview!) : nil
                                    )
                                }
                            }
                        }

                        let emptySlots = itemsPerPage - paginatedDecks.count
                        if emptySlots > 0 {
                            ForEach(0..<emptySlots, id: \.self) { _ in
                                Button(action: {
                                    isAddDeckPopUpVisible = true
                                }) {
                                    EmptyCardComponent(imageData: .constant(nil))
                                }
                                .frame(height: 240)
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

            if isAddDeckPopUpVisible {
                DeckPickerPopUp(isVisible: $isAddDeckPopUpVisible)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .zIndex(2)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DeckListView()
}
