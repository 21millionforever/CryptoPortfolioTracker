//
//  GetTokenImageApi.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/16/24.
//

import Foundation

struct TokenImage: Codable {
    let id = UUID()
    let url: String
    let message: String
}

func fetchTokenImage(tokenSymbol: String) async throws -> TokenImage {

    let endpoint = "\(Config.server_url)/getTokenImage/\(tokenSymbol)"

    guard let url = URL(string: endpoint) else {
        throw APIError.invalidURL
    }

    let data: TokenImage = try await NetworkingManager.fetchData(from: url)
    return data
}
