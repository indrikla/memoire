//
//  DeckCustomPopUp.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI


struct DeckCustomPopUp: View {
    @Binding var isVisible: Bool
    @State var title: String = ""
    @State var numberOfPictures: String = ""
    @StateObject var deckFormViewModel: DeckFormViewModel = DeckFormViewModel(dataService: .shared)

    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { isVisible = false }

                VStack(alignment: .leading, spacing: 42) {
                    HeaderComponent(
                        title: "Customize Your Deck",
                        subtitle: "Add title and number of pictures.",
                        buttons: [
                            AppButton(title: "X", color: .orange, type: .icon, action: {
                                isVisible = false
                            })
                        ]
                    )
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Title")
                            .font(AppTypography.p1b)
                        TextField("Insert Deck Title", text: $title)
                        .padding(20)
                        .background(AppColors.brown2)
                        .cornerRadius(8)
                        .autocapitalization(.sentences)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.clear, lineWidth: 3)
                            )
                        
                        Text("Number of Pictures")
                            .font(AppTypography.p1b)
                        TextField("Insert Number of Pictures", text: $numberOfPictures)
                        .padding(20)
                        .background(AppColors.brown2)
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .autocapitalization(.sentences)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.clear, lineWidth: 3)
                            )
                    }
                    AppButton(title: "Save",
                              color: .purple,
                              type: .large,
                              action: {
                    })
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
    DeckCustomPopUp(isVisible: .constant(true))
}
