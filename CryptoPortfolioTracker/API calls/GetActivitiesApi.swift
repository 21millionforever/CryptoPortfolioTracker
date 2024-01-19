//
//  GetActivitiesApi.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/1/24.
//

import Foundation

struct ActivitiesResponse: Codable, Hashable{
    let id = UUID()
    let type, chian, timeStamp, blockNumber: String
    let hash, status: String
    let extraInfo: ExtraInfo
    
}

struct ExtraInfo: Codable, Hashable {
    let sender, receiver: String?
    let tokenPrice: Double?
    let tokenSymbol: String?
    let tokenName: String?
    let tokenAmount: Double?
    
    let GasUsedETH: Double?
    let GasUsedUSD: Double?

    let sentTokenPrice: Double?
    let sentTokenSymbol: String?
    let sentTokenName: String?
    let sentTokenAmount: Double?
    let receivedTokenSymbol: String?
    let receivedTokenName: String?
    let receivedTokenAmount: Double?
}

func fetchActivities(walletAddress: String) async throws -> [ActivitiesResponse] {
    let endpoint = "\(Config.server_url)/getWalletActivities/\(walletAddress)"
    
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
        return try decoder.decode([ActivitiesResponse].self, from: data)
    } catch {
        throw APIError.invalidData
    }
    
}
