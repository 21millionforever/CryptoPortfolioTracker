//
//  CrossButtonView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/21/24.
//

import SwiftUI

struct CrossButtonView: View {
    var body: some View {
        Image(systemName: "plus")
            .foregroundColor(Color.theme.green)
            .font(.system(size: 30, weight: .bold))
    }
}

struct CrossButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CrossButtonView()
                .previewLayout(.sizeThatFits)
                .colorScheme(.light)
            CrossButtonView()
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }

    }
}
