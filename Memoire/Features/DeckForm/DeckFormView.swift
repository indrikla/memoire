//
//  DeckFormView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct DeckFormView: View {
//    @EnvironmentObject var deckFormVM: DeckFormViewModel
    @State private var deck: Deck = Deck(title: "", image: nil)
    @State private var questions: Int = 5
    
    var body: some View {
        ZStack{
            AppColors.base
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32){
                HeaderComponent(
                    title: "Setup Deck",
                    subtitle: "Add title and questions",
                    buttons: [
                        AppButton(title: "Discard", color: .clear, type: .small, action: {
                            
                        }),
                        AppButton(
                            title: "Save",
                            color: .purple,
                            type: .small,
                            action: {
                                
                            }
                        )

                    ]
                )
                VStack(spacing: 16) {
                    HStack(alignment: .center){
                        TextField("Insert Deck Title...", text: $deck.title)
                            .font(AppTypography.p0b)
                            .foregroundStyle(.white)
                        Spacer()
                        AppButton(
                            title: "Add Question",
                            color: .orange,
                            type: .medium,
                            height:56,
                            action: {
                                // TODO
                        })
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(AppColors.green1)
                    .cornerRadius(16)
                    
                    ScrollView{
                        VStack(spacing: 24) {
                            ForEach(0..<questions, id: \.self) { index in
                                QuestionFormView(questionIndex: index + 1)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 36)
            .padding(.top, 32)
        }
    }
}

#Preview {
    ZStack{
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        DeckFormView()
//        if let firstDeck = DeckViewModel(dataService: .shared).decks.first {
//            DeckFormView(
//                questionViewModel: QuestionViewModel(deck: firstDeck, dataService: .shared)
//            )
//            .environmentObject(DeckViewModel(dataService: .shared))
//        }
    }
}
