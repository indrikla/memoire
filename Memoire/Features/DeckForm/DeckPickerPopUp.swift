//
//  DeckPickerPopUp.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI


struct DeckPickerPopUp: View {
    @Binding var isVisible: Bool

    var body: some View {
        if isVisible {
            ZStack {
                // Full-screen black overlay
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { isVisible = false } // Tap outside to dismiss

                // Popup Content
                VStack(alignment: .leading, spacing: 42) {
                    HeaderComponent(
                        title: "Add New Deck",
                        subtitle: "Create your own or pick from the existing theme!",
                        buttons: [
                            AppButton(title: "X", color: .orange, type: .icon, action: {
                                isVisible = false
                            })
                        ]
                    )
                    VStack(spacing: 12) {
                        AppButton(title: "Custom", color: .green, type: .large, action: {})
                        AppButton(title: "Animal", color: .green, type: .large, action: {})
                        AppButton(title: "People", color: .green, type: .large, action: {})
                        AppButton(title: "Food", color: .green, type: .large, action: {})
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
    DeckPickerPopUp(isVisible: .constant(true))
}
