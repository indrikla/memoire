//
//  QuestionFormView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct QuestionFormView: View {
    let number: Int = 1
    @State private var text: String = ""

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center){
                TextField("My Deck", text: $text)
                    .font(AppTypography.p0b)
                    .foregroundStyle(.white)
                Spacer()
                AppButton(title: "Add Question", color: .orange, type: .medium, height:56, action: {})
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(AppColors.green1)
            .cornerRadius(16)
            
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .trailing, spacing: 0) {
                    Text(String(number))
                        .font(AppTypography.p1b)
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 24)
                .frame(width: 74, alignment: .trailing)
                .background(.white)
                .cornerRadius(16)
                
                HStack(alignment: .top, spacing: 48){
                    VStack(alignment: .leading, spacing: 36){

                    }
                    Spacer()
                    EmptyCardComponent()
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 32)
                .background(.white)
                .cornerRadius(24)
            }
            
            .cornerRadius(16)
        }
    }
}

#Preview {
    ZStack{
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        QuestionFormView()
    }
}
