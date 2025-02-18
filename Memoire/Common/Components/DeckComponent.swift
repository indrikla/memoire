//
//  DeckComponent.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct DeckComponent: View {
    var title: String = "Lorem Ipsum"
    var image: UIImage?
    
    var body: some View {
        VStack(alignment: .center, spacing: -8) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 251, height: 174)
                .background(
                    Group {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 251, height: 174)
                                .clipped()
                        } else {
                            Image("Placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 251, height: 174)
                                .clipped()
                        }
                    }
                )
            ZStack{
                Text(title)
                    .font(AppTypography.custom)
                    .foregroundStyle(AppColors.orange2)
                    .rotationEffect(Angle(degrees: -4))
                    .offset(x:3, y:3)
                Text(title)
                    .font(AppTypography.custom)
                    .foregroundStyle(AppColors.purple1)
                    .rotationEffect(Angle(degrees: -4))
            }
        }
        .padding(10)
        .frame(width: 280, height: 240, alignment: .top)
        .background(.white)
        .shadow(color: AppColors.grey.opacity(0.25), radius: 5, x: 0, y: 4)
        
    }
}

#Preview {
    ZStack{
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        DeckComponent()
    }
}
