//
//  DeckPickerPopUpView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct DeckPickerPopUpView: View {
    @Binding var isVisible: Bool
    @EnvironmentObject private var router: Router

    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { isVisible = false }

                VStack(alignment: .leading, spacing: 42) {
                    HeaderComponent(
                        title: "Add A New Deck",
                        subtitle: "Create your own or pick from the existing theme!",
                        buttons: [
                            AppButton(title: "X", color: .orange, type: .icon, action: {
                                isVisible = false
                            })
                        ]
                    )
                    VStack(spacing: 24) {
                        AppButton(title: "Create Custom Deck", color: .purple, type: .large, height: 90, action: {
                            router.navigate(to: .deckInit)
                        })
                        Divider()
                        Text("Exciting Themes to Choose:")
                            .font(AppTypography.h1_1)
                        HStack(spacing: 32){
                            Button(action: {
                                let deck = JSONLoader.loadSystemDeck(byID: "1")
                                router.navigate(to: .gameplaySystem(systemDeck: deck))
                            }) {
                                DeckComponent(title: "Animals", assetImageName: "AnimalsPlaceholder")
                            }

                            Button(action: {
                                let deck = JSONLoader.loadSystemDeck(byID: "2")
                                router.navigate(to: .gameplaySystem(systemDeck: deck))
                            }) {
                                DeckComponent(
                                    title: "Fruits", assetImageName: "FruitsPlaceholder")
                            }
                        }
                    }
                }
                .padding(.horizontal, 34)
                .padding(.vertical, 48)
                .frame(width: 906, alignment: .topLeading)
                .background(AppColors.base)
                .cornerRadius(24)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .zIndex(2)
            }
        }
    }
}


#Preview {
    DeckPickerPopUpView(isVisible: .constant(true))
}
