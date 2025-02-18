//
//  DeckSetupView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct DeckSetupView: View {
    var body: some View {
        ZStack{
            AppColors.base
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 42){
                HeaderComponent(
                    title: "Setup Deck",
                    subtitle: "Add title and questions",
                    buttons: [
                        AppButton(title: "Discard", color: .clear, type: .small, action: {}),
                        AppButton(title: "Save", color: .purple, type: .small, action: {})
                    ]
                )

            }
            .padding(.horizontal, 80)
        }
    }
}

#Preview {
    DeckSetupView()
}
