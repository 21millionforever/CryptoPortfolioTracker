//
//  MarketDataService.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/27/24.
//

import Foundation

class MarketDataService {
    
    func fetchMarketData() async throws -> GlobalData {
        print("fetchMarketData is called")
        
        let endpoint = "https://api.coingecko.com/api/v3/global"

        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        let data: GlobalData = try await NetworkingManager.fetchData(from: url)
        return data
    }
}
