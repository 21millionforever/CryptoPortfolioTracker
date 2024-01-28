//
//  BalanceView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import SwiftUI

struct BalanceView: View {
    @EnvironmentObject var walletInfoViewModel: WalletsViewModel

    
    var body: some View {
        VStack(spacing: 10) {
            HStack() {
                Text(walletInfoViewModel.totalBalance?.asCurrencyWith2Decimals() ?? "$0.00")
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .redacted(reason: walletInfoViewModel.isWalletsInfoLoaded ? [] : .placeholder)
                   
                Spacer()
            }
        }

    }
        
    
}

//struct BalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        TotalBalanceView(balance: 2000)
//    }
//}
