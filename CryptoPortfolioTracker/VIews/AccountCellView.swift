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
    var walletInfo: WalletInfo
    var walletToBalanceChart: [String: BalanceChartData]
    var istotalBalanceChartDataLoaded: Bool
    
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
                            .foregroundColor(.black)
                        
                        Text(walletInfo.address)
                            .foregroundColor(.black)
                    }
                    .frame(height:40)
                    Spacer()
                    
                    
                    
//                    if (istotalBalanceChartDataLoaded) {
//                        if let balanceChart = walletToBalanceChart[walletInfo.address] {
//                            BalanceChartView(totalBalanceChart: balanceChart, isTotalBalanceChartDataLoaded: istotalBalanceChartDataLoaded, timeInterval: "All", height: 50)
//
//                        } else {
//                            // Handle the case where totalBalanceChart is nil
//                            Text(walletInfo.address)
//                        }
//                    }

                    
                    
                }
//                .frame(height: 110)

                VStack(spacing: 0) {
//                    balanceValue = walletInfo.balanceInUSD {
                    Text("$\(String(format: "%.2f", walletInfo.balanceInUSD))")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.black)

//                    }
                }
                .frame(width: 100, height: 110)
                Spacer()

            }
            GrayDivider()
                .padding()
//            Divider()
//                .frame(height: 1)
//                .overlay(Color.gray.opacity(0.3))
        }
        
    }
}
//struct AccountCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountCellView(address: Config.test_wallet)
//    }
//}

