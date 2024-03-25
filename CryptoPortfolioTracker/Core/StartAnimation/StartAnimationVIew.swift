//
//  StartAnimationVIew.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 2/10/24.
//

import SwiftUI

struct StartAnimationView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack {
            // Example animation: Scale a logo
            Image(systemName: "star.fill") // Replace with your app logo
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(isAnimating ? 1.0 : 0.1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3.0)) {
                        isAnimating = true
                    }
                }
        }
    }
}

//struct StartAnimationVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        StartAnimationVIew()
//    }
//}
