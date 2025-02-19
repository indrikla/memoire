//
//  QuestionTypePickerView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct QuestionTypePickerView: View {
    @Binding var selectedType: QuestionType

    var body: some View {
        VStack(alignment: .leading){
            Text("Question type")
                .font(AppTypography.p1b)
            HStack(spacing: 16){
                ForEach(QuestionType.allCases.filter { $0 != .UNKNOWN }, id: \.self) { type in
                    QuestionTypeButton(
                        title: type.rawValue,
                        isSelected: selectedType == type
                    ) {
                        selectedType = type
                    }
                }
            }
        }
    }
}

struct QuestionTypeButton: View {
    let title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(AppColors.black1)
                    .font(AppTypography.p2)
            }
            .padding(20)
            .background(AppColors.base)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? AppColors.orange1 : Color.clear, lineWidth: 3)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    QuestionTypePickerView(selectedType: .constant(.WHO))
}
