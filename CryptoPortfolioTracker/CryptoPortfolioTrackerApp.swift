//
//  CryptoPortfolioTrackerApp.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//

import SwiftUI

@main
struct CryptoPortfolioTrackerApp: App {
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
                    StartView().environmentObject(sharedDataModel)
                } else {
                    mainContentView
                }
            }
            
            
            
            
//            if !isShowingMainContent {
//                StartAnimationView()
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Match your animation duration
//                            withAnimation {
//                                isShowingMainContent = true
//                            }
//                        }
//                    }
//                    .task {
//                        await balanceChartViewModel.loadChartData(addresses: sharedDataModel.addresses)
//                        await balanceChartViewModel.loadTotalBalance()
//
//                        await walletsHoldingModel.loadWalletsHolding(addresses: sharedDataModel.addresses)
//                        await walletsHoldingModel.loadTotalWalletHolding()
//
//                        await marketViewModel.downloadCoins()
//                        await marketViewModel.downloadMarketData()
//
//                        await marketViewModel.populateSymbolToCoinMap()
//                        await marketViewModel.loadPortfolioCoins(totalWalletTokens: walletsHoldingModel.totalWalletTokens)
//                    }
//            }
//            else if(sharedDataModel.addresses.isEmpty) {
//                StartView()
//                    .environmentObject(sharedDataModel)
//            } else {
//                BottomNavigationBarView()
//                    .environmentObject(balanceChartViewModel)
//                    .environmentObject(sharedDataModel)
//                    .environmentObject(walletsHoldingModel)
//                    .environmentObject(marketViewModel)
//                    .environmentObject(chartHeaderViewModel)
//            }
        }
    }
}

extension CryptoPortfolioTrackerApp {
    private var startAnimationView: some View {
        StartAnimationView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation { isShowingMainContent = true }
                }
            }
            .task { await loadInitialData() }
    }
    
    // Computed property for the main content view
    private var mainContentView: some View {
        BottomNavigationBarView()
            .environmentObject(balanceChartViewModel)
            .environmentObject(sharedDataModel)
            .environmentObject(walletsHoldingModel)
            .environmentObject(marketViewModel)
            .environmentObject(chartHeaderViewModel)
    }
    
    
    // Method to load initial data asynchronously
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
