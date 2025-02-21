//
//  DeckFormView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct DeckInitView: View {
    @State var title: String = ""
    @StateObject var deckFormViewModel = DeckFormViewModel(dataService: .shared)
    @EnvironmentObject private var router: Router
    private var isTitleValid: Bool {
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    @State private var showInvalidInputAlert = false
    
    var body: some View {
        ZStack{
            AppColors.base
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32){
                HeaderComponent(
                    title: "Customize Your Deck",
                    subtitle: "Add title and number of pictures.",
                    buttons: []
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
                    Spacer()
                    HStack(spacing: 24){
                        AppButton(title: "Back",
                                  color: .clear,
                                  type: .large,
                                  action: {
                            router.navigateBack()
                        })
                        AppButton(title: "Save",
                                  color: .purple,
                                  type: .large,
                                  action: {
                            if isTitleValid {
                                let newDeck = deckFormViewModel.addDeck(title: title, image: nil)
                                router.navigate(to: .deckForm(deck: newDeck))
                            } else {
                                showInvalidInputAlert = true
                            }
                        })
                        .alert("Title cannot be blank", isPresented: $showInvalidInputAlert) {
                            Button("Dismiss", role: .cancel) { }
                        } message: {
                            Text("Please insert deck's title.")
                        }
                    }
                }
            }
            .padding(.horizontal, 36)
            .padding(.top, 32)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack{
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        DeckInitView()
    }
}
