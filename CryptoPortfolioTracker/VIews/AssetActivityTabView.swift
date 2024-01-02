//
//  AssetActivityTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct AssetActivityTabView: View {
    let tabs = ["Assets", "Activity"]
    @State private var selectedTab = "Assets"
    var body: some View {
        VStack() {
            VStack(alignment: .leading) {
                // Tabs for selecting the view
                HStack() {
                    ForEach(tabs, id: \.self) { tab in
                        Button(action: {
                            self.selectedTab = tab
                        }) {
                            Spacer()
                            VStack {
                                Text(tab)
                                    .foregroundColor(self.selectedTab == tab ? .orange : .gray)
                            }
                            Spacer()
                        }
                        
                    }
                 
                }
                if(tabs.firstIndex(of: selectedTab) == 0) {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 42.5 / 100, height: 2)
                        .foregroundColor(.orange)
                        .offset(x: UIScreen.main.bounds.width * 5 / 100, y: 0)
                } else {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 42.5 / 100, height: 2)
                        .foregroundColor(.orange)
                        .offset(x: UIScreen.main.bounds.width * 52.5 / 100, y: 0)
                }

            }
            
            VStack {
                // Content based on the selected tab
                switch selectedTab {
                case "Assets":
                    Text(selectedTab)
                case "Activity":
                    Text(selectedTab)
                default:
                    Text(selectedTab)
                }
                
                Spacer()
            }
        }
    }
}

struct AssetActivityTabView_Previews: PreviewProvider {
    static var previews: some View {
        AssetActivityTabView()
    }
}
