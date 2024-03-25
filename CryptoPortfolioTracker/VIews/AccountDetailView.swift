//
//  AccountDetailView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/1/24.
//

import SwiftUI

struct AccountDetailView: View {
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel

    var walletHolding: WalletHolding
    @Environment(\.presentationMode) var presentationMode

    let tabs = ["1W", "1M", "3M", "All"]
    @State private var selectedTab = "All"



    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    BalanceView
                        .padding(.leading)
                    ChartTabView(balanceChartData: balanceChartViewModel.walletToBalanceChart[walletHolding.address.lowercased()] ?? BalanceChartData(), selectedTab: $selectedTab)
                }

                AssetActivityTabView(walletHolding: walletHolding)

            }
            .navigationTitle("Account Balance")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color.theme.green)
                    }
            )

    }

}
extension AccountDetailView {

    private var BalanceView: some View {
        VStack(spacing: 10) {
            HStack() {
                Text("\(balanceChartViewModel.walletToBalanceChart[walletHolding.address.lowercased()]?.all?.last?.value.asCurrencyWith2Decimals() ?? "Unknown")")
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .redacted(reason: balanceChartViewModel.isTotalBalanceChartDataLoaded ? [] : .placeholder)

                Spacer()
            }
        }
    }

}

//struct AccountDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountDetailView(address: Config.test_wallet)
//    }
//}
