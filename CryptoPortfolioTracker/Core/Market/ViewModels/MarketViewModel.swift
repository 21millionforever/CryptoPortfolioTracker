//
//  MarketViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation
import Combine

class MarketViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var filteredCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var portfolioCoins: [CoinModel] = []
    private let coinDataService = CoinDataService()
    
    // Store your subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            await fetchCoins()
        }
        addSubscribers()
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
    
    func addSubscribers() {
        $searchText
            .combineLatest($allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.filteredCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins // Return all coins if search text is empty
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredCoins = coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
        }
        
        return filteredCoins
    }
    
    
}
