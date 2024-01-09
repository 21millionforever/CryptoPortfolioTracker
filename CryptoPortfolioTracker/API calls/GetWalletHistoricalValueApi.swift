//
//  GetWalletHistoricalValueApi.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/8/24.
//

import Foundation

func fetchWalletHistoricalValueChart(walletAddress: String) async throws -> [[Double]] {
    let endpoint = "\(Config.server_url)/getWalletBalanceChart/\(walletAddress)"

    guard let url = URL(string: endpoint) else {
        throw APIError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw APIError.invalidResponse
    }

    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let output = try decoder.decode([[Double]].self, from: data)
//        print(output)
        return output
    } catch {
        throw APIError.invalidData
    }
    
}
