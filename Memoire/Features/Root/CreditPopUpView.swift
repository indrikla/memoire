//
//  CreditPopUpView.swift
//  Memoire
//
//  Created by Risa on 23/02/25.
//

import SwiftUI

struct CreditPopUpView: View {
    @Binding var isVisible: Bool
    let contents: [ContentSection] = JSONLoader.load("Credit")
    @EnvironmentObject private var router: Router

    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { isVisible = false }

                VStack(alignment: .leading, spacing: 32) {
                    HeaderComponent(
                        title: "Acknowledgement",
                        subtitle: "Credits and sources",
                        buttons: [
                            AppButton(title: "X", color: .orange, type: .icon, action: {
                                isVisible = false
                            })
                        ]
                    )
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(contents, id: \.title) { section in
                                VStack(alignment: .leading, spacing: 8) {
                                    VStack(spacing: 8) {
                                        Text(section.title)
                                            .font(AppTypography.p2b)
                                    }
                                    .padding(4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(AppColors.brown1)

                                    if let description = section.description {
                                        Text(description)
                                            .font(AppTypography.p3)
                                    }

                                    if let items = section.items {
                                        ForEach(items) { item in
                                            VStack(alignment: .leading) {
                                                Text(item.title)
                                                    .font(AppTypography.p3b)
                                                Text(item.description)
                                                    .font(AppTypography.p3)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 400)
                }
                .padding(.horizontal, 34)
                .padding(.vertical, 48)
                .frame(width: 906, alignment: .topLeading)
                .background(AppColors.base)
                .cornerRadius(24)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .zIndex(2)
            }
        }
    }
}

#Preview {
    CreditPopUpView(isVisible: .constant(true))
}
