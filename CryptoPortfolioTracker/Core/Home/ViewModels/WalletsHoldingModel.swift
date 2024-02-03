//
//  WalletInfoViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/22/24.
//

import Foundation

//// MARK: - Welcome
//struct WalletInfo: Codable, Hashable{
//    let id = UUID()
//    let address: String
//    let eth: Eth
//    let tokens: [Token]
//    let balanceInUSD: Double
//
//    enum CodingKeys: String, CodingKey {
//        case address
//        case eth = "ETH"
//        case tokens, balanceInUSD
//    }
//}
//
//// MARK: - Eth
//struct Eth: Codable, Hashable {
//    let price: Price
//    let balance: Double
//    let rawBalance: String
//    let totalIn, totalOut: Double
//}
//
//// MARK: - Price
//struct Price: Codable, Hashable {
//    let rate, diff, diff7D: Double
//    let ts: Int
//    let marketCapUsd, availableSupply, volume24H, volDiff1: Double
//    let volDiff7, volDiff30, diff30D: Double
//    let bid: Double?
//    let currency: String?
//
//    enum CodingKeys: String, CodingKey {
//        case rate, diff
//        case diff7D = "diff7d"
//        case ts, marketCapUsd, availableSupply
//        case volume24H = "volume24h"
//        case volDiff1, volDiff7, volDiff30
//        case diff30D = "diff30d"
//        case bid, currency
//    }
//}
//
//// MARK: - Token
//struct Token: Codable, Hashable {
//    let id = UUID()
//    let tokenInfo: TokenInfo
//    let balance: Double
//    let rawBalance: String
//}
//
//// MARK: - TokenInfo
//struct TokenInfo: Codable, Hashable {
//    let address, decimals, name, owner: String
//    let symbol, totalSupply: String
//    let issuancesCount, lastUpdated: Int
//    let price: Price
//    let holdersCount: Int
//    let website: String?
//    let image: String
//    let ethTransfersCount: Int
//    let publicTags: [String]?
//}

// MARK: - Welcome
struct WalletHolding : Codable, Hashable {
    let id = UUID()
    let address: String
    let tokens: [Token]
}

// MARK: - Token
struct Token : Codable, Hashable {
    let id = UUID()
    let token: String
    let amount: Double
}


// TODO: Put wallat info into a service, and change the name of the model to
class WalletsHoldingModel: ObservableObject {
    @Published var walletsHolding = [WalletHolding]()
    @Published var totalWalletTokens = [Token]()
    @Published var isWalletsHoldingLoaded: Bool = false
    
    func fetchWalletHolding(walletAddress: String) async throws -> WalletHolding {
        
        let endpoint = "\(Config.server_url)/getWalletInfo/\(walletAddress)"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let data: WalletHolding = try await NetworkingManager.fetchData(from: url)
        return data
    }
    
    func loadWalletsHolding(addresses: [String]) async {
        await withTaskGroup(of: WalletHolding?.self) { group in
            for address in addresses {
                group.addTask {
                    do {
                        let walletHolding = try await self.fetchWalletHolding(walletAddress: address)
                        return walletHolding
                    } catch {
                        print("Error fetching data for address \(address): \(error)")
                        return nil
                    }
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.walletsHolding = []
            }
            
            for await walletHolding in group {
                if let walletHolding = walletHolding {
                    DispatchQueue.main.async { [weak self] in
                        self?.walletsHolding.append(walletHolding)
                        
                    }
                }
            }
            DispatchQueue.main.async { [weak self] in
                self?.isWalletsHoldingLoaded = true
            }
        }
    }
    
    func loadTotalWalletHolding() {
        // Step 1: Flatten the list of all tokens
        let allTokens = self.walletsHolding.flatMap { $0.tokens }
        
        // Step 2 & 3: Group the tokens by their identifier and sum their amounts
        let groupedTokens = Dictionary(grouping: allTokens, by: { $0.token })
            .mapValues { tokens -> Token in
                // Sum the amounts of tokens with the same identifier
                let totalAmount = tokens.reduce(0) { $0 + $1.amount }
                // Assume all tokens in the group have the same token identifier, so use the first one
                guard let firstToken = tokens.first else {
                    // Handle the unexpected case where tokens is unexpectedly empty
                    // This should theoretically never happen since Dictionary(grouping:by:) should only call this closure for non-empty arrays
                    return Token(token: "Unknown", amount: 0)
                }
                return Token(token: firstToken.token, amount: totalAmount)
            }
            .values // We only care about the grouped Token values, not the keys
        let combinedTokens = Array(groupedTokens)
        
        DispatchQueue.main.async { [weak self] in
            self?.totalWalletTokens = combinedTokens
        }  
    }

    
}
