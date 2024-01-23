//
//  CryptoPortfolioTrackerApp.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//

import SwiftUI

@main
struct CryptoPortfolioTrackerApp: App {
    @StateObject var sharedDataModel = SharedDataModel()
    @StateObject var balanceChartViewModel = BalanceChartViewModel()
    @StateObject var walletInfoViewModel = WalletInfoViewModel()

    
    var body: some Scene {
        WindowGroup {
            BottomNavigationBarView()
                .environmentObject(balanceChartViewModel)
                .environmentObject(sharedDataModel)
                .environmentObject(walletInfoViewModel)
        }
    }
}
