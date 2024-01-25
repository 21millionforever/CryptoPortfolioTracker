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
    let data: BalanceResponse = try await NetworkingManager.fetchData(from: url)
    return data
}
