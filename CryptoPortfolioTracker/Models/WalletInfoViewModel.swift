//
//  WalletInfoViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/22/24.
//

import Foundation

// MARK: - Welcome
struct WalletInfo: Codable, Hashable{
    let id = UUID()
    let address: String
    let eth: Eth
    let tokens: [Token]
    let balanceInUSD: Double

    enum CodingKeys: String, CodingKey {
        case address
        case eth = "ETH"
        case tokens, balanceInUSD
    }
}

// MARK: - Eth
struct Eth: Codable, Hashable {
    let price: Price
    let balance: Double
    let rawBalance: String
    let totalIn, totalOut: Double
}

// MARK: - Price
struct Price: Codable, Hashable {
    let rate, diff, diff7D: Double
    let ts: Int
    let marketCapUsd, availableSupply, volume24H, volDiff1: Double
    let volDiff7, volDiff30, diff30D: Double
    let bid: Double?
    let currency: String?

    enum CodingKeys: String, CodingKey {
        case rate, diff
        case diff7D = "diff7d"
        case ts, marketCapUsd, availableSupply
        case volume24H = "volume24h"
        case volDiff1, volDiff7, volDiff30
        case diff30D = "diff30d"
        case bid, currency
    }
}

// MARK: - Token
struct Token: Codable, Hashable {
    let id = UUID()
    let tokenInfo: TokenInfo
    let balance: Double
    let rawBalance: String
}

// MARK: - TokenInfo
struct TokenInfo: Codable, Hashable {
    let address, decimals, name, owner: String
    let symbol, totalSupply: String
    let issuancesCount, lastUpdated: Int
    let price: Price
    let holdersCount: Int
    let website: String?
    let image: String
    let ethTransfersCount: Int
    let publicTags: [String]?
}



class WalletInfoViewModel: ObservableObject {
    @Published var walletsInfo = [WalletInfo]()
    @Published var totalBalance: Double?
    @Published var isWalletsInfoLoaded: Bool = false
    
    func fetchWalletInfo(walletAddress: String) async throws -> WalletInfo {
        
        let endpoint = "\(Config.server_url)/getWalletInfo/\(walletAddress)"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let data: WalletInfo = try await NetworkingManager.fetchData(from: url)
        return data
    }
    func loadWalletInfo(addresses: [String]) async {
        await withTaskGroup(of: WalletInfo?.self) { group in
            for address in addresses {
                group.addTask {
                    do {
                        let walletInfo = try await self.fetchWalletInfo(walletAddress: address)
                        return walletInfo
                    } catch {
                        print("Error fetching data for address \(address): \(error)")
                        return nil
                    }
                }
            }
            
            for await walletInfo in group {
                DispatchQueue.main.async {
                    self.walletsInfo = []
                    self.totalBalance = 0.00
                }
                if let walletInfo = walletInfo {
                    DispatchQueue.main.async { [weak self] in
                        self?.walletsInfo.append(walletInfo)
                        self?.totalBalance = (self?.totalBalance ?? 0.00) + walletInfo.balanceInUSD
                        
                    }
                }
            }
            DispatchQueue.main.async { [weak self] in
                self?.isWalletsInfoLoaded = true
            }
        }
        
    
    }

    
}
