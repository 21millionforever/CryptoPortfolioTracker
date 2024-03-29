//
//  CoinModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/24/24.
//

import Foundation


//{
//  "id": "bitcoin",
//  "symbol": "btc",
//  "name": "Bitcoin",
//  "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
//  "current_price": 39741,
//  "market_cap": 781006899913,
//  "market_cap_rank": 1,
//  "fully_diluted_valuation": 836476782259,
//  "total_volume": 23129591109,
//  "high_24h": 40499,
//  "low_24h": 39027,
//  "price_change_24h": 439.19,
//  "price_change_percentage_24h": 1.11746,
//  "market_cap_change_24h": 11411397929,
//  "market_cap_change_percentage_24h": 1.48278,
//  "circulating_supply": 19607412,
//  "total_supply": 21000000,
//  "max_supply": 21000000,
//  "ath": 69045,
//  "ath_change_percentage": -42.24998,
//  "ath_date": "2021-11-10T14:24:11.849Z",
//  "atl": 67.81,
//  "atl_change_percentage": 58702.47544,
//  "atl_date": "2013-07-06T00:00:00.000Z",
//  "roi": null,
//  "last_updated": "2024-01-24T20:39:55.739Z",
//  "sparkline_in_7d": {
//    "price": [
//      42374.46162247654,
//      42549.27806320843,
//    ]
//  },
//  "price_change_percentage_24h_in_currency": 1.117457798098187
//}
struct Coin: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    var currentHoldings: Double?
    
    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue: Double? {
        if let currentHoldings = currentHoldings {
            return currentHoldings * currentPrice
        }
        return nil
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
