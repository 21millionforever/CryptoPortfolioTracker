//
//  AccountCellView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/1/24.
//

import SwiftUI
import Charts
import Foundation


struct AccountCellView: View {
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel
    
    var walletInfo: WalletInfo
//    var walletToBalanceChart: [String: BalanceChartData]
//    var istotalBalanceChartDataLoaded: Bool
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(spacing:0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack() {
                        Image("SVG_MetaMask_Icon_Color")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)

                        Text("MetaMask")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.mainText)
                        
                        Text(walletInfo.address)
                            .foregroundColor(Color.theme.mainText)
                    }
                    .frame(height:40)
                    Spacer()
                    
                    
                    
                    if (balanceChartViewModel.isTotalBalanceChartDataLoaded) {
                            BalanceChartView(timeInterval: "All", height: 50)
                    }

                    
                    
                }

                VStack(spacing: 0) {
                    Text(walletInfo.balanceInUSD.asCurrencyWith2Decimals())
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.theme.mainText)


                }
                .frame(width: 100, height: 110)
                Spacer()

            }
            GrayDivider()
                .padding()
        }
        
    }
}
//struct AccountCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountCellView(address: Config.test_wallet)
//    }
//}

