//
//  AppTypography.swift
//  Memoire
//
//  Created by Risa on 17/02/25.
//

import SwiftUI

enum AppTypography {
    static let title = Font.custom("Skia", size: 48).weight(.black)
    static let h1 = Font.custom("Skia", size: 28).weight(.black)
    static let h1_1 = Font.custom("Skia", size: 28).weight(.bold)

    static let p0b = Font.custom("Poppins-Bold", size: 36)
    static let p1 = Font.custom("Poppins-Regular", size: 24)
    static let p1b = Font.custom("Poppins-Bold", size: 24)
    static let p2 = Font.custom("Poppins-Regular", size: 20)
    static let p2b = Font.custom("Poppins-Bold", size: 20)
    
    static let custom = Font.custom("Skincake", size: 48)
}
