//
//  EmptyCardComponent.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct EmptyCardComponent: View {
    @Binding var imageData: Data?
    
    var body: some View {
        ZStack(alignment: .center) {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280)
                    .clipped()
                    .cornerRadius(24)
            } else {
                Rectangle()
                    .foregroundStyle(.clear)
                    .background(AppColors.base)
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .inset(by: 2)
                            .stroke(AppColors.brown1, style: StrokeStyle(lineWidth: 4, dash: [22, 22]))
                    )
                
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 54, height: 54)
                    .foregroundStyle(AppColors.brown1)
            }
        }
    }
}


#Preview {
    EmptyCardComponent(imageData: .constant(nil))
}
