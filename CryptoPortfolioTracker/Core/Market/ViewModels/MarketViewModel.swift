//
//  MarketViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation

class MarketViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    private let coinDataService = CoinDataService()
    
    @Published var searchText: String = ""
    
    init() {
        Task {
            await fetchCoins()
        }
    }

    private func fetchCoins() async {
        do {
            let fetchedCoins = try await coinDataService.fetchCoinsData()
            DispatchQueue.main.async { [weak self] in
                self?.allCoins = fetchedCoins
            }
        } catch {
            print("Error fetching coins: \(error)")
            // Handle the error appropriately
        }
    }
    
}
