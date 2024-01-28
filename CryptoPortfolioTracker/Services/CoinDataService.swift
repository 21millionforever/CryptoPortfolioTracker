//
//  CoinDataService.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation

class CoinDataService {

    func fetchCoinsData() async throws -> [Coin] {
        print("fetchCoinsData is called")
        
        let endpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&x_cg_demo_api_key=\(Config.coingecko_api_key)"

        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        let data: [Coin] = try await NetworkingManager.fetchData(from: url)
        return data
    }


}
