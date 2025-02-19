//
//  GameplayView.swift
//  Memoire
//
//  Created by Risa on 18/02/25.
//

import SwiftUI

struct GameplayView: View {
    var body: some View {
        ZStack{
            AppColors.base
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 42){
                HeaderComponent(
                    title: "Can you guess it?",
                    subtitle: "Tap a tile to reveal a part of a mystery image and try to guess it!",
                    buttons: [
                        AppButton(title: "X", color: .orange, type: .icon, action: {})
                    ]
                )
                HStack(alignment: .top, spacing: 48){
                    ZStack{
                        Image("Placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 600, height: 600)
                            .clipped()
                        CardRevealComponent()
                        
                    }
                    VStack(alignment: .center, spacing: 40){
                        Text("Who is this")
                            .font(AppTypography.title)
                        VStack(spacing: 24) {
                            AppButton(title: "Louis", color: .green, type: .large, height: 90, action: {})
                            AppButton(title: "Louis", color: .green, type: .large, height: 90, action: {})
                            AppButton(title: "Louis", color: .green, type: .large, height: 90, action: {})
                        }
                        Spacer()
                    }
                    .padding(24)
                    .background(AppColors.brown1)
                    .cornerRadius(24)
                }
            }
            .padding(36)
        }
    }
}

#Preview {
    GameplayView()
}
