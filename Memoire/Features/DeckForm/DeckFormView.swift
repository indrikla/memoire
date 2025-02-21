//
//  DeckFormView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI
import PhotosUI

struct DeckFormView: View {
    let deck: Deck
    @ObservedObject var deckFormViewModel: DeckFormViewModel
    @EnvironmentObject private var router: Router
    
    @State var questionType: QuestionType = .UNKNOWN
    @State var questionText: String = ""
    @State var correctAnswerIndex: Int = -1
    @State var answers: [String] = [""]
    @State var imageData: Data? = nil
    @State private var showValidationAlert = false
    private var validationErrors: [String] {
        var errors: [String] = []
        
        if questionType == .UNKNOWN {
            errors.append("Please select a question type.")
        }
        
        if answers.contains(where: { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
            errors.append("All answer fields must be filled.")
        }
        
        if correctAnswerIndex < 0 {
            errors.append("Please select a correct answer.")
        }
        
        if imageData == nil {
            errors.append("Please upload an image.")
        }
        
        return errors
    }
    
    var body: some View {
        ZStack{
            AppColors.base
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16){
                HStack(alignment: .center){
                    HeaderComponent(
                        title: deck.title,
                        subtitle: "Add title and answer to each pictures",
                        buttons: [
                            AppButton(title: "Discard", color: .clear, type: .small,
                                      action: {
                                          deckFormViewModel.deleteDeck(deck)
                                          router.navigate(to: .deckList)
                            }),
                            AppButton(
                                title: "Create Deck",
                                color: .orange,
                                type: .medium,
                                isDisabled: deckFormViewModel.questions.isEmpty,
                                action: {                                    deckFormViewModel.saveQuestionToDeck(
                                        deck: deck,
                                        questions: deckFormViewModel.questions
                                    )
                                    router.navigate(to: .gameplay(deck: deck))
                                }
                            )
//                            .id(deckFormViewModel.questions.count)

                        ]
                    )
                }
                .padding(.horizontal, 25)
                .frame(width: .infinity, height: 125)
                .background(AppColors.brown2)
                .cornerRadius(16)
                
                VStack(alignment:.trailing ,spacing: 16) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .trailing, spacing: 0) {
                            Text(String(deckFormViewModel.questions.count + 1))
                                .font(AppTypography.p1b)
                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical, 24)
                        .background(.white)
                        .cornerRadius(16)
                        
                        HStack(alignment: .top, spacing: 36) {
                            VStack(alignment: .leading, spacing: 36) {
                                QuestionTypePickerView(
                                    selectedType: $questionType
                                )
                                AnswerSelectionView(
                                    selectedOption: $correctAnswerIndex,
                                    answers: $answers
                                )
                            }
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 24){
                                Text("Picture")
                                    .font(AppTypography.p1b)
                                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                                    EmptyCardComponent(imageData: $imageData)

                                }
                                .frame(width: 280)
                                .onChange(of: photoPickerItem) { _, newValue in
                                    loadSelectedImage(newValue)
                                }
                            }
                        }
                        .padding(40)
                        .background(.white)
                        .cornerRadius(24)
                    }
                    .frame(height: 550)
                    
                    HStack(spacing: 24){
                        Text("Total questions: \(deckFormViewModel.questions.count)")
                            .font(AppTypography.p1b)
                        Spacer()
                        AppButton(
                            title: "Save Question",
                            color: .purple,
                            type: .medium,
                            action: {
                                if validationErrors.isEmpty {
                                    let image = imageData.flatMap { UIImage(data: $0) }
                                    deckFormViewModel.addQuestionToArray(
                                        questionType: questionType,
                                        questionText: questionType.questionText,
                                        answers: answers,
                                        correctAnswerIndex: correctAnswerIndex,
                                        image: image
                                    )
                                    if deckFormViewModel.questions.count == 1 {
                                        deckFormViewModel.addImagePreview(deck, image: image)
                                    }

                                    questionType = .UNKNOWN
                                    questionText = ""
                                    correctAnswerIndex = -1
                                    answers = [""]
                                    imageData = nil
                                    photoPickerItem = nil
                                } else {
                                    showValidationAlert = true
                                }
                            }
                        )
                        .alert("Invalid Input", isPresented: $showValidationAlert) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text(validationErrors.joined(separator: "\n"))
                        }

                    }
                }
            }
            .padding(.horizontal, 36)
            .padding(.top, 16)
        }
        .navigationBarBackButtonHidden()
    }
    
    @State private var photoPickerItem: PhotosPickerItem? = nil
    private func loadSelectedImage(_ newValue: PhotosPickerItem?) {
        guard let newValue = newValue else { return }
        Task {
            if let data = try? await newValue.loadTransferable(type: Data.self) {
                imageData = data
            }
        }
    }
}


#Preview {
    ZStack{
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        DeckFormView(deck: Deck(title: "My Deeckkk"), deckFormViewModel: DeckFormViewModel(dataService: .shared))
    }
}
