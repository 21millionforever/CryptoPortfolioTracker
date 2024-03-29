//
//  CoinDataService.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation

class CoinDataService {
    /**
     Call api "https://api.coingecko.com/api/v3/coins/markets" and return the result
     - Returns: Return the result from the api call
    */
    func fetchCoinsData() async throws -> [Coin] {
        print("fetchCoinsData is called")
        
        let endpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&x_cg_demo_api_key=\(Config.coingecko_api_key)"

        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        var data: [Coin] = try await NetworkingManager.fetchData(from: url)
        
        let endpoint2 = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=2&sparkline=true&price_change_percentage=24h&locale=en&x_cg_demo_api_key=\(Config.coingecko_api_key)"

        guard let url = URL(string: endpoint2) else {
            throw APIError.invalidURL
        }
        var data2: [Coin] = try await NetworkingManager.fetchData(from: url)

        data += data2
        
        return data
    }


}
