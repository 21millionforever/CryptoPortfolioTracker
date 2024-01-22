//
//  ContentView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//
import Charts

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    // An array of wallet addresses
//    @State var addresses: [String] = [Config.test_wallet]

//    @State var walletsInfo: [WalletInfo] = []

    // The sum of the balance of all the wallets
    @State var totalBalance: Double?
    
    @State var isTotalBalanceLoaded: Bool = false
    @State private var showBottomMenu: Bool = false
    @State var showingImportWalletView: Bool = false

    
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
                    
                    ChartTabView(selectedTab: $selectedTab)

                    HStack() {
                        Text("Accounts")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading)


//                    if (balanceChartViewModel.isTotalBalanceChartDataLoaded) {
//                        ForEach(walletsInfo, id: \.id) { walletInfo in
//                            NavigationLink(value: walletInfo) {
//                                AccountCellView(walletInfo: walletInfo)
//
//                                    .padding(.leading)
//                            }
//                        }
//                    }
//                    else {
//                        AccountCellSectionPlaceHolderView()
//                    }
                    

                }
                .navigationTitle("Total Balance")

            }
            .navigationDestination(for: WalletInfo.self) { walletInfo in
                AccountDetailView(walletInfo: walletInfo)
            }
//            .navigationDestination(isPresented: $showingImportWalletView, destination: {ImportWalletView(addresses: $addresses, showingImportWalletView: $showingImportWalletView)})
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {showBottomMenu.toggle()})
                    {
                        CrossButtonView()
                    }
                    .rotationEffect(Angle(degrees: showBottomMenu ? 45 : 0))
                    .animation(.spring(), value: showBottomMenu) // Apply the animation to the rotation effect based on the `showBottomMenu` value
                    .sheet(isPresented: $showBottomMenu) {
                        BottomSheetView(navigateToImportWalletView: $showingImportWalletView, showingBottomMenu: $showBottomMenu)
                            .padding()
                            .presentationDetents([.fraction(0.2)])
                            .presentationDragIndicator(.visible)
                    }
                }
            }
//            .task {
                // Get wallet info for each wallet and calculate total balance
//                if walletsInfo.isEmpty {
//                    var totalBalanceTmp = 0.00
//                    var fetchedWalletsInfo = [WalletInfo]()
//
//                    do {
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
//                }
//            }
            
            
            
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
//            .onChange(of: addresses) { newValue in
//                guard let lastAddress = addresses.last else { return }
//
//                Task {
//                    do {
//                        let walletInfo = try await fetchWalletInfo(walletAddress: lastAddress)
//                        DispatchQueue.main.async {
//                            self.totalBalance = (self.totalBalance ?? 0) + walletInfo.balanceInUSD
//                            self.walletsInfo.append(walletInfo)
//                        }
//
//                    } catch APIError.invalidURL {
//                        print("Invalid url")
//                    } catch APIError.invalidResponse {
//                        print("Invalid response")
//                    } catch APIError.invalidData {
//                        print("Invalid Data")
//                    } catch {
//                        print("An unexpected error: \(error.localizedDescription)")
//                    }
//                }
//            }
            .onChange(of: balanceChartViewModel.addresses) { newAddresses in
                guard let lastAddress = newAddresses.last else { return }
                Task {
                    await balanceChartViewModel.loadSingleAddressChartData(address: lastAddress)
                    
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


