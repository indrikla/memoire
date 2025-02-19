//
//  AnswerSelectionView.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftUI

struct AnswerSelectionView: View {
    @Binding var selectedOption: Int
    @Binding var answers: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Answer")
                    .font(AppTypography.p1b)
                Text("Type and select the right option")
                    .font(AppTypography.p1)
            }
            VStack(alignment: .leading, spacing: 16) {
                ForEach(0..<3, id: \.self) { index in
                    HStack {
                        Button(action: {
                            selectedOption = index
                        }) {
                            Image(systemName: selectedOption == index ? "largecircle.fill.circle" : "circle")
                                .foregroundColor(selectedOption == index ? .blue : .gray)
                        }

                        TextField("Input Answer Option \(index + 1) Here...", text: Binding(
                            get: {
                                if index < answers.count {
                                    return answers[index]
                                } else {
                                    return ""
                                }
                            },
                            set: { newValue in
                                if index < answers.count {
                                    answers[index] = newValue
                                } else {
                                    answers.append(newValue)
                                }
                            }
                        ))
                        .padding(20)
                        .background(AppColors.base)
                        .cornerRadius(8)
                        .autocapitalization(.sentences)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedOption == index ? AppColors.orange1 : Color.clear, lineWidth: 3)
                        )
                    }
                    .background(.clear)
                }
            }
        }
    }
}


#Preview {
    AnswerSelectionView(
        selectedOption: .constant(1),
        answers: .constant([""])
    )
}
