//
//  BottomNavigationBar.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/5/24.
//

import SwiftUI

struct BottomNavigationBarView: View {
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel
    @EnvironmentObject var walletInfoViewModel: WalletInfoViewModel
    @EnvironmentObject var sharedDataModel : SharedDataModel
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    init() {
        // Set the unselected item color
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.secondaryText)
        
        // Set the tab bar background color (optional)
        UITabBar.appearance().backgroundColor = UIColor(Color.theme.background)
    }
    
    var body: some View {

        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "chart.line.uptrend.xyaxis")
                        .foregroundColor(.black)
                }

            SettingsView()
                .tabItem {
                    Label("Second", systemImage: "gearshape")
                }
        }
        .accentColor(Color.theme.accent)
        .task {
            await balanceChartViewModel.loadChartData(addresses: sharedDataModel.addresses)
            await walletInfoViewModel.loadWalletInfo(addresses: sharedDataModel.addresses)
        }
        .onReceive(timer) { _ in
            Task {
                await balanceChartViewModel.loadChartData(addresses: sharedDataModel.addresses)
                await walletInfoViewModel.loadWalletInfo(addresses: sharedDataModel.addresses)
            }
        }
    }
}

//struct BottomNavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomNavigationBarView()
//    }
//}
