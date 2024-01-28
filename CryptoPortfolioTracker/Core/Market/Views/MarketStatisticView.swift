//
//  MarketStatisticView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/27/24.
//

import SwiftUI

struct MarketStatisticView: View {
    @EnvironmentObject private var marketViewModel: MarketViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(marketViewModel.statistics) { stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
    }
}

struct MarketStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        MarketStatisticView()
            .environmentObject(dev.marketVM)
    }
}
