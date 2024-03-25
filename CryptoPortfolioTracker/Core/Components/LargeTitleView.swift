//
//  LargeTitleView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/23/24.
//

import SwiftUI

struct LargeTitleView: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
}

struct LargeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        LargeTitleView(text: "Accounts")
    }
}
