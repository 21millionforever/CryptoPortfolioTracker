//
//  MarketView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import SwiftUI

struct MarketView: View {
    @EnvironmentObject private var marketViewModel: MarketViewModel
    @EnvironmentObject private var walletsHoldingModel: WalletsHoldingModel
    @State private var isPortfolioCoinsLoaded = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    MarketStatisticView()
                    
                    SearchBarView(searchText: $marketViewModel.searchText)
                    
                    columnTitles
                    
                    allCoinsList
                        .listStyle(PlainListStyle())
                        .task {
                            if !isPortfolioCoinsLoaded {
                                marketViewModel.loadPortfolioCoins(totalWalletTokens: walletsHoldingModel.totalWalletTokens)
                                DispatchQueue.main.async {
                                    self.isPortfolioCoinsLoaded = true
                                }
                            }
                            
                        }
                }
                .navigationTitle("Market")
            }
        }
        
    }
}




extension MarketView {
    private var allCoinsList: some View {

            ForEach(marketViewModel.filteredCoins) { coin in
                CoinRowView(coin: coin)
                    .padding(.trailing, 10)
            }

    }
    
    private var columnTitles: some View {
        HStack(spacing: 0) {
            Text("#")
                .padding(.leading, 10)
            Text("Coin")
                .padding(.leading, 10)
            
            Spacer()
            Text("Holdings")
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
                .padding(.trailing, 10)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
    }
    
    
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
            .environmentObject(dev.marketVM)
    }
}
