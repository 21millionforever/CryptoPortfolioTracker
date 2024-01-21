//
//  ContentView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//
import Charts

import SwiftUI

struct BalanceChartData {
    var all: [ChartDataPoint]?
    var oneWeek: [ChartDataPoint]?
    var oneDay: [ChartDataPoint]?
    var live: [ChartDataPoint]?
}



struct ContentView: View {
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    // An array of wallet addresses
    @State var addresses: [String] = [Config.test_wallet]

    @State var walletsInfo: [WalletInfo] = []

    // The sum of the balance of all the wallets
    @State var totalBalance: Double?

    // wallet address maps to balance chart
    @State private var walletToBalanceChart: [String: BalanceChartData] = [:]

    // The balance chart of all the wallets combine
    @State var totalBalanceChart = BalanceChartData()
    
    @State var isTotalBalanceLoaded = false
    @State var isTotalBalanceChartDataLoaded = false
    @State private var showingBottomMenu = false
    @State var showingImportWalletView = false

    
    let tabs = ["LIVE", "1D", "1W", "1M", "3M", "All"]
    @State private var selectedTab = "All"


    var currentDate: String {
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: now)
    }


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    BalanceView(balance: totalBalance, isBalanceLoaded: isTotalBalanceLoaded)
                        .padding(.leading)
                    
                    ChartTabView(selectedTab: $selectedTab, balanceChart: totalBalanceChart, isDataLoaded: isTotalBalanceChartDataLoaded, totalBalance: totalBalance)

                    HStack() {
                        Text("Accounts")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading)


                    if (isTotalBalanceChartDataLoaded) {
                        ForEach(walletsInfo, id: \.id) { walletInfo in
                            NavigationLink(value: walletInfo) {
                                AccountCellView(walletInfo: walletInfo, walletToBalanceChart: walletToBalanceChart, istotalBalanceChartDataLoaded: isTotalBalanceChartDataLoaded)

                                    .padding(.leading)
                            }
                        }
                    }
                    else {
                        AccountCellSectionPlaceHolderView()
                    }
                    

                }
                .navigationTitle("Total Balance")

            }
            .navigationDestination(for: WalletInfo.self) { walletInfo in
                AccountDetailView(walletInfo: walletInfo, balanceChart: walletToBalanceChart[walletInfo.address] ?? BalanceChartData() , isTotalBalanceChartDataLoaded: isTotalBalanceChartDataLoaded)
            }
            .navigationDestination(isPresented: $showingImportWalletView, destination: {ImportWalletView(addresses: $addresses, showingImportWalletView: $showingImportWalletView)})
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {

                    Button(action: {
                        showingBottomMenu = true})
                    {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .sheet(isPresented: $showingBottomMenu) {
                        BottomSheetView(navigateToImportWalletView: $showingImportWalletView, showingBottomMenu: $showingBottomMenu)
                            .padding()
                            .presentationDetents([.fraction(0.2)])
                            .presentationDragIndicator(.visible)
                    }
                }
            }
            .task {
                // Get wallet info for each wallet and calculate total balance
                if walletsInfo.isEmpty {
                    var totalBalanceTmp = 0.00
                    var fetchedWalletsInfo = [WalletInfo]()

                    do {
                        for address in addresses {
                            let walletInfo = try await fetchWalletInfo(walletAddress: address)
                            totalBalanceTmp += walletInfo.balanceInUSD
                            fetchedWalletsInfo.append(walletInfo)
                        }

                        DispatchQueue.main.async {
                            self.walletsInfo = fetchedWalletsInfo
                            self.totalBalance = totalBalanceTmp
                            self.isTotalBalanceLoaded = true
                        }
                    } catch APIError.invalidURL {
                        print("Invalid url")
                    } catch APIError.invalidResponse {
                        print("Invalid response")
                    } catch APIError.invalidData {
                        print("Invalid Data")
                    } catch {
                        // Handle other errors
                        print("An unexpected error: \(error.localizedDescription)")
                    }
                }

                // Get historical balance for all the wallets
                if walletToBalanceChart.isEmpty {
                    do {
                        var tempWalletToBalanceChart = [String: BalanceChartData]()
                        for address in addresses {
                            let lowerCaseAddress = address.lowercased()
                            var existingChartData = tempWalletToBalanceChart[lowerCaseAddress] ?? BalanceChartData()
                            
                            let tempMaxBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: address, days: "max")
                            existingChartData.all = tempMaxBalanceChart
                            
                            let tempOneWeekBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: address, days: "7")
                            existingChartData.oneWeek = tempOneWeekBalanceChart
                            print("Test")
                            print(tempOneWeekBalanceChart)
                            
//                            let tempOneDayBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: address, days: "1")
//                            existingChartData.oneDay = tempOneDayBalanceChart

                            tempWalletToBalanceChart[lowerCaseAddress] = existingChartData
                        }
                        let tempMaxChartData = CalculateTotalBalanceChart(walletToBalanceChart: tempWalletToBalanceChart, timeInterval: "max")
                        let tempOneWeekChartData = CalculateTotalBalanceChart(walletToBalanceChart: tempWalletToBalanceChart, timeInterval: "7")
//                        let tempOneDayChartData = CalculateTotalBalanceChart(walletToBalanceChart: tempWalletToBalanceChart, timeInterval: "1")
                        
                        DispatchQueue.main.async {
                            self.walletToBalanceChart = tempWalletToBalanceChart
                            self.totalBalanceChart.all = tempMaxChartData
                            self.totalBalanceChart.oneWeek = tempOneWeekChartData
//                            self.totalBalanceChart.oneDay = tempOneDayChartData
                            self.isTotalBalanceChartDataLoaded = true
                        }
                        
                        
                    } catch APIError.invalidURL {
                        print("Invalid url")
                    } catch APIError.invalidResponse {
                        print("Invalid response")
                    } catch APIError.invalidData {
                        print("Invalid Data")
                    } catch {
                        // Handle other errors
                        print("An unexpected error: \(error.localizedDescription)")
                    }
                }
            }
//            .onReceive(timer) { _ in
//                Task {
//
//                    do {
//                        var totalBalanceTmp = 0.00
//                        var fetchedWalletsInfo = [WalletInfo]() // Replace WalletInfoType with your actual type
//
//                        for address in addresses {
//                            let walletInfo = try await fetchWalletInfo(walletAddress: address)
//                            totalBalanceTmp += walletInfo.balanceInUSD
//                            fetchedWalletsInfo.append(walletInfo)
//                        }
//
//                        DispatchQueue.main.async {
//                            self.walletsInfo = fetchedWalletsInfo
//                            self.totalBalance = totalBalanceTmp
//                            self.isTotalBalanceLoaded = true
//                        }
//
//                    } catch APIError.invalidURL {
//                        print("Invalid url")
//                    } catch APIError.invalidResponse {
//                        print("Invalid response")
//                    } catch APIError.invalidData {
//                        print("Invalid Data")
//                    } catch {
//                        // Handle other errors
//                        print("An unexpected error: \(error.localizedDescription)")
//                    }
//
//
//
//                    do {
//                        var tempWalletToBalanceChart = [String: BalanceChartData]()
//
//                        for address in addresses {
//                            let tempAllBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: address, days: "max")
//                            let lowerCaseAddress = address.lowercased()
//                            var existingChartData = tempWalletToBalanceChart[lowerCaseAddress] ?? BalanceChartData()
//                            existingChartData.all = tempAllBalanceChart
//
//                            let tempOneWeekBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: address, days: "7")
//                            existingChartData.oneWeek = tempOneWeekBalanceChart
//
//                            let tempOneDayBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: address, days: "1")
//                            existingChartData.oneDay = tempOneDayBalanceChart
//
//                            tempWalletToBalanceChart[lowerCaseAddress] = existingChartData
//                        }
//                        let allchartData = CalculateTotalBalanceChart(walletToBalanceChart: tempWalletToBalanceChart, timeInteval: "All")
//                        let oneWeekChartData = CalculateTotalBalanceChart(walletToBalanceChart: tempWalletToBalanceChart, timeInteval: "7")
//                        let oneDayChartData = CalculateTotalBalanceChart(walletToBalanceChart: tempWalletToBalanceChart, timeInteval: "1")
//
//
//
//                        DispatchQueue.main.async {
//                            self.walletToBalanceChart = tempWalletToBalanceChart
//                            self.totalBalanceChart.all = allchartData
//                            self.totalBalanceChart.oneWeek = oneWeekChartData
//                            self.totalBalanceChart.oneDay = oneDayChartData
//                            self.isTotalBalanceChartDataLoaded = true
//                        }
//                    } catch APIError.invalidURL {
//                        print("Invalid url")
//                    } catch APIError.invalidResponse {
//                        print("Invalid response")
//                    } catch APIError.invalidData {
//                        print("Invalid Data")
//                    } catch {
//                        // Handle other errors
//                        print("An unexpected error")
//                    }
//                }
//            }
            
            // When a new wallet is added, add the balance of the new wallet to the Total Balance and get the wallet Info for the wallet
            .onChange(of: addresses) { newValue in
                guard let lastAddress = addresses.last else { return }
                
                Task {
                    do {
                        let walletInfo = try await fetchWalletInfo(walletAddress: lastAddress)
                        DispatchQueue.main.async {
                            self.totalBalance = (self.totalBalance ?? 0) + walletInfo.balanceInUSD
                            self.walletsInfo.append(walletInfo)
                        }

                    } catch APIError.invalidURL {
                        print("Invalid url")
                    } catch APIError.invalidResponse {
                        print("Invalid response")
                    } catch APIError.invalidData {
                        print("Invalid Data")
                    } catch {
                        print("An unexpected error: \(error.localizedDescription)")
                    }
                }
            }
            
            
            
            
            
            
            
        }

    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


