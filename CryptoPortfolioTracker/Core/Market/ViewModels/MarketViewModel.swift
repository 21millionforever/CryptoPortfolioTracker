//
//  MarketViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation
import Combine

class MarketViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var filteredCoins: [Coin] = []
    @Published var searchText: String = ""
    @Published var portfolioCoins: [Coin] = []
//    @Published var marketData: GlobalData?
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    // Store your subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    @Published var statistics: [Statistic] = [
    ]
    
    init() {
        Task {
            await downloadCoins()
            await downloadMarketData()
        }
        addSubscribers()
    }

    private func downloadCoins() async {
        do {
            let fetchedCoins = try await coinDataService.fetchCoinsData()
            DispatchQueue.main.async { [weak self] in
                self?.allCoins = fetchedCoins
            }
        } catch let error {
            print("Error fetching coins: \(error)")
            // Handle the error appropriately
        }
    }
    
    private func downloadMarketData() async {
        do {
            
            let fetchedMarketData = try await marketDataService.fetchMarketData()
            
            let marketCap = Statistic(title: "Market Cap", value: fetchedMarketData.data?.marketCap ?? "Error", percentageChange: fetchedMarketData.data?.marketCapChangePercentage24HUsd)
            let volume = Statistic(title: "Total Volume", value: fetchedMarketData.data?.volume ?? "Error")
            let btcDominance = Statistic(title: "BTC Dominance", value: fetchedMarketData.data?.btcDominance ?? "Error")
            
            DispatchQueue.main.async { [weak self] in
                self?.statistics = []
                self?.statistics.append(contentsOf: [marketCap, volume, btcDominance])
            }
            

            
        } catch let error {
            print("Error fetching market data: \(error)")
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
    
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
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
