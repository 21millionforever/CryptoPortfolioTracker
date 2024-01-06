//
//  AssetActivityTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct AssetActivityTabView: View {
    let timer = Timer.publish(every: 120, on: .main, in: .common).autoconnect()
    let tabs = ["Assets", "Activity"]
    @State private var selectedTab = "Assets"
    @State private var activities: [ActivitiesResponse] = []
    
    var walletInfo: WalletInfo
    
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
                    NavigationStack {
                        VStack {
                            ForEach(walletInfo.tokens, id: \.id) { tokenInfo in
                                AssetTokenCellView(tokenInfo: tokenInfo)
                                Divider()
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                    case "Activity":
                        ActivityView(activities: activities)
                    default:
                        Text(selectedTab)
                }
                
                Spacer()
            }
        }
        .task {
            if activities.isEmpty {
                do {
                    activities = try await fetchActivities(walletAddress: Config.test_wallet)
                } catch APIError.invalidURL {
                    print("Invalid url")
                } catch APIError.invalidResponse {
                    print("Invalid response")
                } catch APIError.invalidData {
                    print("Invalid Data")
                } catch {
                    // Handle other errors
                    print("An unexpected error")
                }
            }
        }
        .onReceive(timer) { _ in
            Task {
                do {
                    activities = try await fetchActivities(walletAddress: Config.test_wallet)
                } catch APIError.invalidURL {
                    print("Invalid url")
                } catch APIError.invalidResponse {
                    print("Invalid response")
                } catch APIError.invalidData {
                    print("Invalid Data")
                } catch {
                    // Handle other errors
                    print("An unexpected error")
                }
            }
        }
        
        
        
        
        
        
        
        
        
    }
    
    func formatTokenBalance(tokenInfo: Token) -> String {
        let balance = Double(tokenInfo.balance)
        let decimals = Double(tokenInfo.tokenInfo.decimals) ?? 18
        let formattedBalance = balance / pow(10.0, decimals)
        return String(format: "%.2f", formattedBalance)
    }
    
    func calculateTokenValueInUSD(tokenInfo: Token) -> String {
        let balance = Double(tokenInfo.balance)
        let decimals = Double(tokenInfo.tokenInfo.decimals) ?? 18
        let formattedBalance = balance / pow(10.0, decimals)
        let tokenValueInUSD = formattedBalance * tokenInfo.tokenInfo.price.rate
        return formatAsCurrency(number: tokenValueInUSD)
    }
    
}

//struct AssetActivityTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetActivityTabView()
//    }
//}
