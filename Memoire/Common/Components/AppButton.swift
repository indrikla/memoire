//
//  AppButton.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

enum ButtonColorType: Equatable {
    case green, purple, orange, clear
}
enum ButtonType: Equatable {
    case icon, small, medium, large
}

struct AppButton: View, Identifiable {
    var id = UUID()
    var title: String = "Lorem Ipsum"
    var color: ButtonColorType = .purple
    var type: ButtonType = .medium
    var height: CGFloat = 72
    var action: () -> Void
    
    private var backgroundColor: Color {
        switch color {
        case .green:
            return AppColors.green1
        case .purple:
            return AppColors.purple1
        case .orange:
            return AppColors.orange1
        case .clear:
            return .clear
        }
    }
    
    private var strokeColor: Color {
        switch color {
        case .green:
            return AppColors.green2
        case .purple:
            return AppColors.purple2
        case .orange:
            return AppColors.orange2
        case .clear:
            return .clear
        }
    }
    
    private var width: CGFloat {
        switch type {
        case .icon:
            return 85
        case .small:
            return 140
        case .medium:
            return 360
        case .large:
            return 0
        }
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(color == .clear ? AppTypography.h1_1 : AppTypography.h1)
                .foregroundStyle(color == .clear ? AppColors.black : .white)
                .padding()
                .frame(maxWidth: type == .large ? .infinity : width, minHeight: height)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .inset(by: 2)
                    .stroke(strokeColor, lineWidth: 4)
                )
                .cornerRadius(12)
        }
    }
}

#Preview {
    ZStack{
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        VStack{
            AppButton(title: "Start", color:.green, action: {})
            AppButton(title: "How to Play", color:.clear, action: {})
        }
    }
}
