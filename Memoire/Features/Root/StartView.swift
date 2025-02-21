//
//  StartView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject private var router: Router

    var body: some View {
        ZStack{
            Image("HomeBackground")
                .resizable()
                .scaledToFill()
            VStack(alignment: .center, spacing: 12){
                Image("Logo")
                AppButton(title: "Start", color:.green, type:.medium, action: {
                    router.navigate(to: .deckList)
                })
                AppButton(title: "How to Play",  color:.orange, type:.medium, action: {
                    
                })
            }
        }
    }
}

#Preview {
    StartView()
}
