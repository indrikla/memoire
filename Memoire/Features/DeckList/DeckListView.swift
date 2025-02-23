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
    @State private var selectedDeckForDeletion: Deck?
    @State private var isDeleteAlertVisible = false
    @State private var isLongPressActive: Bool = false
    @EnvironmentObject private var router: Router

    private let itemsPerPage = 6
    private let columns = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]

    private var sortedDecks: [Deck] {
        deckListViewModel.decks.sorted { $0.id.uuidString < $1.id.uuidString }
    }

    private var totalDecks: Int {
        sortedDecks.count
    }

    private var totalPages: Int {
        let fullPages = (totalDecks / itemsPerPage)
        let hasExtraPage = totalDecks % itemsPerPage > 0
        return fullPages + (hasExtraPage ? 1 : 1)
    }

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
    

    private func deleteDeck() {
        if let deck = selectedDeckForDeletion {
            withAnimation {
                deckListViewModel.deleteDeck(deck)
                deckListViewModel.fetchDecks()
            }
            selectedDeckForDeletion = nil
        }
    }



    var body: some View {
        ZStack {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    SIMD2(0.0, 0.0), SIMD2(0.5, 0.0), SIMD2(1.0, 0.0),
                    SIMD2(0.0, 0.5), SIMD2(0.5, 0.5), SIMD2(1.0, 0.5),
                    SIMD2(0.0, 1.0), SIMD2(0.5, 1.0), SIMD2(1.0, 4.0)
                ],
                colors: [
                    .purple1, .purple2,
                    .purple2, .purple1, .purple1,
                    .purple1, .purple2, .purple1
                ]
            )
            .scaledToFill()
            Image("Book")
                .scaledToFit()

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
                                if deckListViewModel.decks.contains(where: { $0.id == deck.id }) {
                                    Button(action: {
                                        print("\(deck.title) clicked in DeckLisrView")
                                        if !isLongPressActive {
                                            if deckListViewModel.decks.contains(where: { $0.id == deck.id }) {
                                                    router.navigate(to: .gameplay(deck: deck))
                                            } else {
                                                print("Deck no longer exists.")
                                            }
                                        } else {
                                            print("gamasuk gameplay")
                                        }
                                    }) {
                                        DeckComponent(
                                            title: deck.title,
                                            image: deck.imagePreview != nil ? UIImage(data: deck.imagePreview!) : nil
                                        )
                                    }
                                    .simultaneousGesture(
                                        LongPressGesture(minimumDuration: 0.8)
                                            .sequenced(before: DragGesture(minimumDistance: 0))
                                            .onChanged { _ in
                                                isLongPressActive = true
                                                print("Long press activated in DeckLisrView")
                                            }
                                            .onEnded { _ in
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    isLongPressActive = false
                                                }
                                                selectedDeckForDeletion = deck
                                                isDeleteAlertVisible = true
                                            }
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
                                    EmptyDeckComponent(imageData: .constant(nil))
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
                DeckPickerPopUpView(isVisible: $isAddDeckPopUpVisible)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .zIndex(2)
            }
        }
        .alert("Delete Deck", isPresented: $isDeleteAlertVisible) {
            Button("Cancel", role: .cancel) { selectedDeckForDeletion = nil }
            Button("Delete", role: .destructive) { deleteDeck() }
        } message: {
            Text("Are you sure you want to delete this deck?")
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    DeckListView()
}
