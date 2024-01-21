//
//  BottomNavigationBar.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/5/24.
//

import SwiftUI

struct BottomNavigationBarView: View {
    init() {
        // Set the unselected item color
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
        // Set the tab bar background color (optional)
        UITabBar.appearance().backgroundColor = UIColor.white
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
            
            // Add more tabs as needed
        }
        .accentColor(.black)
    }
}

struct BottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBarView()
    }
}
