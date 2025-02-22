//
//  SystemGameplayView.swift
//  Memoire
//
//  Created by Risa on 23/02/25.
//

import SwiftUI

struct SystemGameplayView: View {
    var systemDeck: SystemDeck
    
    @State private var currentQuestionIndex = 0
    @State private var hiddenAnswers: Set<Int> = []
    @State private var isCorrectAnswerPopUpVisible: Bool = false
    @State private var isLastQuestion: Bool = false
    @State private var correctAnswer: String = ""
    @State private var flippedCards: Set<String> = []

    @State private var isExplosionVisible = true
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            AppColors.base
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 42) {
                HeaderComponent(
                    title: systemDeck.title,
                    subtitle: "Tap a tile to reveal a part of a mystery image and try to guess it!",
                    buttons: [
                        AppButton(title: "X", color: .orange, type: .icon, action: {
                            router.navigate(to: .deckList)
                        })
                    ]
                )
                
                HStack(alignment: .top, spacing: 48) {
                    if systemDeck.questions.indices.contains(currentQuestionIndex) {
                        let question = systemDeck.questions[currentQuestionIndex]
                        
                        ZStack {
                            Image(question.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 600, height: 600)
                                .clipped()
                            
                            CardsRevealComponent(flippedCards: $flippedCards)
                                .id(currentQuestionIndex)
                        }
                        
                        VStack(alignment: .center, spacing: 40) {
                            VStack(alignment: .center, spacing: 12) {
                                Text("Question no. \(currentQuestionIndex + 1) of \(systemDeck.questions.count)")
                                    .font(AppTypography.p1)
                                Text(question.questionText)
                                    .font(AppTypography.title)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                            }

                            VStack(spacing: 24) {
                                ForEach(Array(question.answers.enumerated()), id: \.offset) { index, answer in
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
                                                    print("✅ Correct Answer Selected: \(answer)")
                                                    correctAnswer = answer
                                                    isLastQuestion = (currentQuestionIndex == systemDeck.questions.count - 1)
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
                                isExplosionVisible = true
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
                    correctAnswer: correctAnswer
                )
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .zIndex(2)
                if isExplosionVisible {
                    ParticleExplosion(isExplosionVisible: $isExplosionVisible)
                        .zIndex(3)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

