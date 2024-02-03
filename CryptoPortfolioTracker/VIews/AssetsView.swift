//
//  AssetsView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/15/24.
//

import SwiftUI

struct AssetsView: View {
    var walletHolding: WalletHolding

    var body: some View {
        VStack {
            ForEach(walletHolding.tokens, id: \.id) { tokenInfo in
                NavigationLink(value: tokenInfo) {
                    AssetTokenCellView(tokenInfo: tokenInfo)
                }
                GrayDivider()
            }
        }
        .padding([.leading, .trailing])
        .navigationDestination(for: Token.self) {tokenInfo in
            Text("Token")
        }
    }
}

//struct AssetsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetsView()
//    }
//}
