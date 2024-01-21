//
//  CryptoPortfolioTrackerApp.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//

import SwiftUI

@main
struct CryptoPortfolioTrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            BottomNavigationBarView()
        }
    }
}

// TODO
// 1. Make API calls when the variables are empty, after the first call, then is 1 API call every 5 minutes
