//
//  DeckConfigurationView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct DeckConfigurationView: View {
    @State private var deckTitle: String = ""
    @State private var questionNumber: Int = 1
    @State var questions: [Question] = []
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center){
                TextField("My Deck", text: $deckTitle)
                    .font(AppTypography.p0b)
                    .foregroundStyle(.white)
                Spacer()
                AppButton(
                    title: "Add Question",
                    color: .orange,
                    type: .medium,
                    height:56,
                    action: {
                        questionNumber += 1
                    })
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(AppColors.green1)
            .cornerRadius(16)
            
            ScrollView{
                VStack(spacing: 24) {
                    ForEach(0..<questionNumber, id: \.self) { index in
                        QuestionFormView(questionIndex: index + 1)
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack{
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        DeckConfigurationView()
    }
}
