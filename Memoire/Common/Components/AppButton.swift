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
    var isDisabled: Bool = false
    var action: () -> Void
    
    private var backgroundColor: Color {
        switch color {
        case .green:
            return isDisabled ? AppColors.green1.opacity(0.5) : AppColors.green1
        case .purple:
            return isDisabled ? AppColors.purple1.opacity(0.5) : AppColors.purple1
        case .orange:
            return isDisabled ? AppColors.orange1.opacity(0.5) : AppColors.orange1
        case .clear:
            return .clear
        }
    }
    
    private var strokeColor: Color {
        switch color {
        case .green:
            return isDisabled ? AppColors.green2.opacity(0.5) : AppColors.green2
        case .purple:
            return isDisabled ? AppColors.purple2.opacity(0.5) : AppColors.purple2
        case .orange:
            return isDisabled ? AppColors.orange2.opacity(0.5) : AppColors.orange2
        case .clear:
            return .clear
        }
    }
    
    private var textColor: Color {
        return isDisabled ? AppColors.grey : (color == .clear ? AppColors.black1 : .white)
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
        Button(action: action)
        {
            Text(title)
                .font(color == .clear ? AppTypography.h1_1 : AppTypography.h1)
                .foregroundStyle(textColor)
                .padding()
                .frame(maxWidth: type == .large ? .infinity : width, minHeight: height)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 2)
                        .stroke(strokeColor, lineWidth: 4)
                )
                .cornerRadius(12)
                .opacity(isDisabled ? 0.5 : 1)
                .grayscale(isDisabled ? 0.8 : 0)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    ZStack {
        AppColors.base
            .edgesIgnoringSafeArea(.all)
        VStack {
            AppButton(title: "Start", color: .green, isDisabled: false, action: {})
            AppButton(title: "Disabled", color: .purple, isDisabled: true, action: {})
            AppButton(title: "How to Play", color: .clear, action: {})
        }
    }
}
