//
//  CorrectAnwerPopUp.swift
//  Memoire
//
//  Created by Risa on 21/02/25.
//

import SwiftUI

struct CorrectAnwerPopUp: View {
    @Binding var isVisible: Bool
    @Binding var isLastQuestion: Bool
    @Binding var currentQuestionIndex: Int

    var correctAnswer: String = ""
    var imagePreview: UIImage?
    @EnvironmentObject private var router: Router
    
    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { isVisible = false }
                
                HStack(spacing:32){
                    if imagePreview != nil {
                        Image(uiImage: imagePreview!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 400, height: 300)
                            .clipped()
                            .cornerRadius(16)
                    } else {
                        Image("Placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 400, height: 300)
                            .clipped()
                            .cornerRadius(16)
                    }
                    
                    
                    VStack(alignment: .center, spacing: 32) {
                        VStack(spacing: 12){
                            Text("It's \(correctAnswer)!")
                                .font(AppTypography.title)
                                .foregroundStyle(AppColors.black1)
                            Text("Tell a story about \(correctAnswer). \n What’s your favorite memory about \(correctAnswer)?")
                                .font(AppTypography.p1)
                        }
                        .multilineTextAlignment(.center)
                        
                        VStack(spacing: 12) {
                            if isLastQuestion {
                                AppButton(title: "Finish Game", color: .orange, type: .large, action: {
                                    router.navigate(to: .deckList)
                                })
                            } else {
                                AppButton(title: "Next Puzzle", color: .purple, type: .large, action: {
                                    currentQuestionIndex += 1
                                    isVisible = false
                                })
                            }
                        }
                    }
                }
                .padding(48)
                .frame(width: 900, alignment: .topLeading)
                .background(AppColors.base)
                .cornerRadius(24)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .zIndex(2)
                
            }
        }
    }
}

#Preview {
    CorrectAnwerPopUp(isVisible: .constant(true), isLastQuestion: .constant(true), currentQuestionIndex: .constant(1))
}
