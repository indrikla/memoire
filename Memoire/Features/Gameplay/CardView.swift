//
//  CardView.swift
//  Memoire
//
//  Created by Risa on 19/02/25.
//

import SwiftUI

struct CardView: View {
    var isFlipped: Bool
    @State private var rotation: Double = 0
    @State private var isHidden = false

    var body: some View {
        ZStack {
            if isHidden {
                Color.clear
            } else {
                Image("CardCover")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .rotation3DEffect(
                        .degrees(rotation),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            rotation = 180
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isHidden = true
                        }
                    }
            }
        }
        .frame(width: 200, height: 200)
    }
}




#Preview {
    CardView(isFlipped: false)
}
