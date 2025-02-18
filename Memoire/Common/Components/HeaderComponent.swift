//
//  HeaderComponent.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct HeaderComponent: View {
    let title: String
    let subtitle: String
    let buttons: [AppButton]
    
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading, spacing: 8){
                Text(title)
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.black)
                Text(subtitle)
                    .font(AppTypography.p1)
            }
            Spacer()
            HStack(spacing: 32) {
                ForEach(buttons) { button in
                    AppButton(title: button.title, color: button.color, type: button.type, action: button.action)
                }
            }
        }
    }
}

#Preview {
    HeaderComponent(
        title: "Title",
        subtitle: "Subtitle",
        buttons: [
            AppButton(title: "Discard", color: .clear, type: .small, action: {}),
            AppButton(title: "Save", color: .purple, type: .small, action: {})
        ]
    )
}
