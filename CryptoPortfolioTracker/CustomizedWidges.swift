//
//  CustomizedWidges.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/17/24.
//

import Foundation
import SwiftUI

struct GrayDivider: View {
    let color: Color = .gray
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
