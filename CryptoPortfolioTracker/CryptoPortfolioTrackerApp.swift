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
    @StateObject private var walletInfoViewModel = WalletsViewModel()
    @StateObject private var marketViewModel = MarketViewModel()

    
    var body: some Scene {
        WindowGroup {
            if(sharedDataModel.addresses.isEmpty) {
                StartView()
                    .environmentObject(sharedDataModel)
            } else {
                BottomNavigationBarView()
                    .environmentObject(balanceChartViewModel)
                    .environmentObject(sharedDataModel)
                    .environmentObject(walletInfoViewModel)
                    .environmentObject(marketViewModel)
            }
        }
    }
}
