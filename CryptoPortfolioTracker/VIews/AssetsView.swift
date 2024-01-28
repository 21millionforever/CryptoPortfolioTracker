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
            NavigationLink(value: walletInfo.eth) {
                AssetEthCellView(eth: walletInfo.eth)
            }
            GrayDivider()
//            Divider()
//                .frame(height: 1)
//                .overlay(Color.gray.opacity(0.3))
            
            ForEach(walletInfo.tokens, id: \.id) { tokenInfo in
                NavigationLink(value: tokenInfo) {
                    AssetTokenCellView(tokenInfo: tokenInfo)
                }
                GrayDivider()
//                Divider()
//                    .frame(height: 1)
//                    .overlay(Color.gray.opacity(0.3))
            }
        }
        .padding([.leading, .trailing])
        .navigationDestination(for: Token.self) {tokenInfo in
            Text("Token")
        }
        .navigationDestination(for: Eth.self) { Eth in
            Text("Eth")
            
        }
        
    }
}
//
//struct AssetsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetsView()
//    }
//}
