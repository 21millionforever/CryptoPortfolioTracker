//
//  MarketView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import SwiftUI

struct MarketView: View {
    @EnvironmentObject private var marketViewModel: MarketViewModel
    var body: some View {
        List {
            CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: false)
        }
        .listStyle(PlainListStyle())
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
            .environmentObject(dev.marketVM)
    }
}
