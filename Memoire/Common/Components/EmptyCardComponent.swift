//
//  EmptyCardComponent.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct EmptyCardComponent: View {
    var body: some View {
        ZStack(alignment: .center){
            Rectangle()
              .foregroundStyle(.clear)
              
              .background(AppColors.base)
              .cornerRadius(24)
              .overlay(
                RoundedRectangle(cornerRadius: 24)
                  .inset(by: 2)
                  .stroke(AppColors.brown, style: StrokeStyle(lineWidth: 4, dash: [22, 22]))
              )
            Image(systemName: "plus")
                .resizable()
                .frame(width: 54, height: 54)
                .foregroundStyle(AppColors.brown)
        }
        .frame(width: 280, height: 240)
    }
}

#Preview {
    EmptyCardComponent()
}
