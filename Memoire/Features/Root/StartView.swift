//
//  StartView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject private var router: Router
    @State private var isHowToPlayPopUpVisible = false
    @State private var isCreditPopUpVisible = false

    var body: some View {
        ZStack{
            Image("ColorfulBackground")
                .resizable()
                .scaledToFill()

            Image("Book")
                .scaledToFit()

            VStack(alignment: .center, spacing: 12){
                Image("Logo")
                    .scaledToFit()
                
                AppButton(title: "Start", color:.purple, type:.medium, action: {
                    router.navigate(to: .deckList)
                })
                AppButton(title: "How to Play",  color:.orange, type:.medium, action: {
                    isHowToPlayPopUpVisible = true
                })
                
            }
            AppButton(title: "⭐",  color:.green, type:.icon, action: {
                isCreditPopUpVisible = true
            })
            .position(x: 1020, y: 200)
            
            if isHowToPlayPopUpVisible {
                HowToPlayPopUpView(isVisible: $isHowToPlayPopUpVisible)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .zIndex(2)
            }
            
            if isCreditPopUpVisible {
                CreditPopUpView(isVisible: $isCreditPopUpVisible)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .zIndex(2)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    StartView()
}
