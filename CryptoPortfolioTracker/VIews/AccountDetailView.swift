//
//  AccountDetailView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/1/24.
//

import SwiftUI

struct AccountDetailView: View {
    var walletInfo: WalletInfo
    @Environment(\.presentationMode) var presentationMode
    var balanceChart: BalanceChartData
    var isTotalBalanceChartDataLoaded: Bool
    
    let tabs = ["LIVE", "1D", "1W", "1M", "3M", "All"]
    @State private var selectedTab = "All"
    
  

    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    TotalBalanceView(balance: walletInfo.balanceInUSD, isBalanceLoaded: isTotalBalanceChartDataLoaded)
                        
                    
//                    HStack(spacing: 3) {
//                        Image(systemName: "arrowtriangle.up.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 15, height: 15)
//                            .foregroundColor(.green)
//
//                        Text("$645.55")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//
//                        Text("(0.69%)")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//
//                        Text("Today")
//                            .font(.subheadline)
//                            .fontWeight(.light)
//
//                    }
                    
                    ChartTabView(selectedTab: $selectedTab, balanceChart: balanceChart, isDataLoaded: isTotalBalanceChartDataLoaded)
                }
                .padding([.leading], 20)
                
                AssetActivityTabView(walletInfo: walletInfo)
          
            }
            .navigationTitle("Total Balance")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.green)
                    }
            )
    
    }
    
}

//struct AccountDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountDetailView(address: Config.test_wallet)
//    }
//}
