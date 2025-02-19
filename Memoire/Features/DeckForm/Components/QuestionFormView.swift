//
//  QuestionFormView.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftUI
import PhotosUI

struct QuestionFormView: View {
    @Binding var question: Question
    let questionIndex: Int
    @State private var photoPickerItem: PhotosPickerItem? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .trailing, spacing: 0) {
                Text(String(questionIndex))
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
                        selectedType: $question.questionType
                    )
                    AnswerSelectionView(
                        selectedOption: $question.correctAnswerIndex,
                        answers: $question.answers
                    )
                }
                Spacer()
                
                VStack(spacing: 24){
                    PhotosPicker(selection: $photoPickerItem, matching: .images) {
                        EmptyCardComponent(imageData: $question.imageData)

                    }
                    .frame(width: 280, height: .infinity)
                    .onChange(of: photoPickerItem) { _, newValue in
                        loadSelectedImage(newValue)
                    }
                    AppButton(title: "Save Question", color: .green, action: {
                        addQuestionToArray
                    })
                }
            }
            .padding(40)
            .background(.white)
            .cornerRadius(24)
        }
        .frame(height: 550)
    }

    private func loadSelectedImage(_ newValue: PhotosPickerItem?) {
        guard let newValue = newValue else { return }
        Task {
            if let data = try? await newValue.loadTransferable(type: Data.self) {
                question.imageData = data
            }
        }
    }
}

#Preview {
    QuestionFormView(
        question: .constant(
            Question(questionType: .WHO,
                 questionText: "",
                 answers: [""],
                 correctAnswerIndex: 0,
                 deck: nil
                )
        ),
        questionIndex: 1
    )
}
