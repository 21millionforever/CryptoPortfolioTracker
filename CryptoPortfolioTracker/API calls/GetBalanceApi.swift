//
//  GetBalanceApi.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import Foundation

struct BalanceResponse: Codable {
    let balance: Double
    let message: String
}

func fetchTotalBalance(walletAddress: String) async throws -> BalanceResponse {
    
    let endpoint = "\(Config.server_url)/getWalletUsdBalance/\(walletAddress)"
    
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
        return try decoder.decode(BalanceResponse.self, from: data)
    } catch {
        throw APIError.invalidData
    }
    
    
    
}
