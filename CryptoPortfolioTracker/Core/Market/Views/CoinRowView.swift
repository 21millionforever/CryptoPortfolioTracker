//
//  CoinRowView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/24/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
//    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
//            if showHoldingsColumn {
            centerColumn
//            }
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
        }

        
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.mainText)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            if let currentHoldingValue = coin.currentHoldingValue {
                Text(currentHoldingValue.asCurrencyWith2Decimals())
            }
            else {
                Text("")
            }
            
            if let currentHolding = coin.currentHoldings {
                Text(currentHolding.asNumberString())
            }
            else {
                Text("")
            }
//            Text(coin.currentHoldingValue.asCurrencyWith2Decimals())
//                .bold()
//            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.mainText)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(Color.theme.mainText)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "N/A")
                .foregroundColor(coin.priceChangePercentage24H ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
    }
    
    
    
    
}
