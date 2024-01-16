//
//  AssetsView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/15/24.
//

import SwiftUI

struct AssetsView: View {
    var walletInfo: WalletInfo
    
    var body: some View {
        VStack {
            ForEach(walletInfo.tokens, id: \.id) { tokenInfo in
                NavigationLink(value: tokenInfo) {
                    AssetTokenCellView(tokenInfo: tokenInfo)
                }
                Divider()
            }
        }
        .padding([.leading, .trailing])
        .navigationDestination(for: Token.self) {tokenInfo in
            TestView()
        }
    }
}
//
//struct AssetsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetsView()
//    }
//}
