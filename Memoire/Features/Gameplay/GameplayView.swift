//
//  GameplayView.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftUI

struct GameplayView: View {
    let deck: Deck
    @State private var currentQuestionIndex = 0
    @State private var hiddenAnswers: Set<Int> = []
    @State private var isCorrectAnswerPopUpVisible: Bool = false
    @State private var isLastQuestion: Bool = false
    @State private var correctAnswer: String = ""
    @State private var imagePreview: UIImage? = nil
    @State private var flippedCards: Set<String> = []
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            AppColors.base
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 42) {
                HeaderComponent(
                    title: "Can you guess it?",
                    subtitle: "Tap a tile to reveal a part of a mystery image and try to guess it!",
                    buttons: [
                        AppButton(title: "X", color: .orange, type: .icon, action: {
                            router.navigate(to: .deckList)
                        })
                    ]
                )
                
                HStack(alignment: .top, spacing: 48) {
                    if deck.questions.indices.contains(currentQuestionIndex) {
                        let question = deck.questions[currentQuestionIndex]
                        
                        ZStack {
                            if let imageData = question.imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 600, height: 600)
                                    .clipped()
                                    .onAppear {
                                        imagePreview = uiImage
                                    }
                            } else {
                                Image("Placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 600, height: 600)
                                    .clipped()
                            }
                            CardRevealComponent(flippedCards: $flippedCards)
                                .id(currentQuestionIndex)
                        }
                        
                        VStack(alignment: .center, spacing: 40) {
                            Text(question.questionText)
                                .font(AppTypography.title)

                            VStack(spacing: 24) {
                                ForEach(Array(question.answers.enumerated()), id: \.element) { index, answer in
                                    if !hiddenAnswers.contains(index) {
                                        AppButton(
                                            title: answer,
                                            color: .green,
                                            type: .large,
                                            height: 90,
                                            action: {
                                                if index != question.correctAnswerIndex {
                                                    hiddenAnswers.insert(index)
                                                } else {
                                                    print("Correct Answer Selected: \(answer)")
                                                    correctAnswer = answer
                                                    isLastQuestion = (currentQuestionIndex == deck.questions.count - 1)
                                                    isCorrectAnswerPopUpVisible = true
                                                }
                                            }
                                        )
                                    }
                                }
                            }
                            .onChange(of: currentQuestionIndex) {
                                hiddenAnswers.removeAll()
                                flippedCards.removeAll()
                            }

                            Spacer()
                        }
                        .padding(.vertical, 24)
                        .padding(24)
                        .background(AppColors.brown2)
                        .cornerRadius(24)
                    }
                }
            }
            .padding(36)
            
            if isCorrectAnswerPopUpVisible {
                CorrectAnwerPopUp(
                    isVisible: $isCorrectAnswerPopUpVisible,
                    isLastQuestion: $isLastQuestion,
                    currentQuestionIndex: $currentQuestionIndex,
                    correctAnswer: correctAnswer,
                    imagePreview: imagePreview
                )
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .zIndex(2)
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    GameplayView(deck: Deck(title: ""))
}
