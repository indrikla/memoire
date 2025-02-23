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
    
    @State private var isZoomedIn = false

    var body: some View {
        ZStack{
            Image("ColorfulBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)

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
            GeometryReader { geometry in
                let xPosition = geometry.size.width / 9 * 7
                let yPosition = geometry.size.height / 4

                AppButton(title: "⭐", color: .green, type: .icon, action: {
                    isCreditPopUpVisible = true
                })
                .position(x: xPosition, y: yPosition)
            }
            
            if isHowToPlayPopUpVisible {
                HowToPlayPopUpView(isVisible: $isHowToPlayPopUpVisible)
                    .zIndex(2)
            }
            
            if isCreditPopUpVisible {
                CreditPopUpView(isVisible: $isCreditPopUpVisible)
                    .zIndex(2)
            }
        }
    }
}

#Preview {
    StartView()
}
