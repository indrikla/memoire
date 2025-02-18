//
//  DeckPickerView.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

struct DeckPickerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 42){
            HeaderComponent(
                title: "Add New Deck",
                subtitle: "Create your own or pick from the existing theme!",
                buttons: [
                    AppButton(title: "X", color: .orange, type: .icon, action: {})
                ]
            )
            VStack(spacing: 12){
                AppButton(title: "Custom", color: .green, type: .large, action: {})
                AppButton(title: "Custom", color: .green, type: .large, action: {})
                AppButton(title: "Custom", color: .green, type: .large, action: {})
                AppButton(title: "Custom", color: .green, type: .large, action: {})
            }
        }
        .padding(.horizontal, 34)
        .padding(.vertical, 48)
        .frame(width: 906, alignment: .topLeading)
        .background(AppColors.base)
        .cornerRadius(24)
    }
}

#Preview {
    DeckPickerView()
}
