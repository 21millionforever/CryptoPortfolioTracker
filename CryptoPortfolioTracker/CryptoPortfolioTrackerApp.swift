//
//  CryptoPortfolioTrackerApp.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//

import SwiftUI
import OSLog

@main
struct CryptoTrackerApp: App {
    @StateObject private var sharedDataModel = SharedDataModel()
    @StateObject private var balanceChartViewModel = BalanceChartViewModel()
    @StateObject private var walletsHoldingModel = WalletsHoldingModel()
    @StateObject private var marketViewModel = MarketViewModel()
    @StateObject private var chartHeaderViewModel = ChartHeaderViewModel()
    
    // State for controlling the display of the main content
    @State private var isShowingMainContent = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !isShowingMainContent {
                    startAnimationView
                } else if sharedDataModel.addresses.isEmpty {
                    StartView()
                        .environmentObject(sharedDataModel)
                }
                else {
                    mainContentView
                }
            }
            
        }
    }
}

extension CryptoTrackerApp {
    private var startAnimationView: some View {
        StartAnimationView()
            .onAppear {
                if (!sharedDataModel.addresses.isEmpty) {
                    Task {
                        await loadInitialData()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation { isShowingMainContent = true }
                }
                
            }
    }
    
    
    // Computed property for the main content view
    private var mainContentView: some View {
        BottomNavigationBarView()
            .onAppear {
                Task {
                    await loadInitialData()
                }}
            .environmentObject(balanceChartViewModel)
            .environmentObject(sharedDataModel)
            .environmentObject(walletsHoldingModel)
            .environmentObject(marketViewModel)
            .environmentObject(chartHeaderViewModel)
    }
    
    
    private func loadInitialData() async {
        await balanceChartViewModel.loadChartData(addresses: sharedDataModel.addresses)
        await balanceChartViewModel.loadTotalBalance()
        
        await walletsHoldingModel.loadWalletsHolding(addresses: sharedDataModel.addresses)
        await walletsHoldingModel.loadTotalWalletHolding()
        
        await marketViewModel.downloadCoins()
        await marketViewModel.downloadMarketData()
        
        await marketViewModel.populateSymbolToCoinMap()
        await marketViewModel.loadPortfolioCoins(totalWalletTokens: walletsHoldingModel.totalWalletTokens)
        
    }
}


