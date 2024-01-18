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
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw APIError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(TokenImage.self, from: data)
        return response
    } catch {
        throw APIError.invalidData
    }
}
