//
//  HomeView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel
    @EnvironmentObject var walletsHoldingModel: WalletsHoldingModel
    @EnvironmentObject var sharedDataModel : SharedDataModel
    
    @State private var showBottomMenu: Bool = false
    @State var showingImportWalletView: Bool = false
    @State private var selectedTab = "All"
    let tabs = ["1W", "1M", "3M", "All"]
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    TotalBalanceView
                        .padding(.leading)
                    
                    ChartTabView(balanceChartData: balanceChartViewModel.totalBalanceChart, selectedTab: $selectedTab)
                    
                    AccountsHeaderView
                        .padding(.leading)

                    AccountsSectionView
                    

                }
                .navigationTitle("Total Balance")

            }
            .navigationDestination(isPresented: $showingImportWalletView, destination: {ImportWalletView(showingImportWalletView: $showingImportWalletView)})
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    TopMenuButtonView
                    .sheet(isPresented: $showBottomMenu) {
                        bottomSheetView()
                    }
                }
            }
            .onChange(of: sharedDataModel.addresses) { newAddresses in
                guard let lastAddress = newAddresses.last else { return }
                Task {
                    await balanceChartViewModel.loadChartData(addresses: sharedDataModel.addresses)
                    await balanceChartViewModel.loadTotalBalance()
                    
                    await walletsHoldingModel.loadWalletsHolding(addresses: sharedDataModel.addresses)
                    await walletsHoldingModel.loadTotalWalletHolding()
                }
            }
            
            
        }
    }
}

extension HomeView {
    private var TotalBalanceView: some View {
        VStack(spacing: 10) {
            HStack() {
                Text(balanceChartViewModel.balance.asCurrencyWith2Decimals())
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .redacted(reason: balanceChartViewModel.isTotalBalanceChartDataLoaded ? [] : .placeholder)
                    .animation(.easeInOut(duration: 0.3), value: balanceChartViewModel.balance) // Add animation here
                   
                Spacer()
            }
        }
    }
    
    
    
    private var AccountsHeaderView: some View {
        HStack {
            LargeTitleView(text: "Accounts")
            Spacer()
        }
    }
    
    private var TopMenuButtonView: some View {
        Button(action: { showBottomMenu.toggle() }) {
            CrossButtonView()
                .rotationEffect(Angle(degrees: showBottomMenu ? 45 : 0))
                .animation(.spring(), value: showBottomMenu)
        }
    }
    
    private func bottomSheetView() -> some View {
        BottomSheetView(navigateToImportWalletView: $showingImportWalletView, showingBottomMenu: $showBottomMenu)
            .padding()
            .presentationDetents([.fraction(0.2)])
            .presentationDragIndicator(.visible)
    }
    
    private var AccountCellSectionPlaceHolderView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 100) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10)
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 100) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10)
        }
    }
    
    private var AccountsSectionView: some View {
        Group {
            if balanceChartViewModel.isTotalBalanceChartDataLoaded {
                ForEach(walletsHoldingModel.walletsHolding, id: \.id) { walletHolding in
                    NavigationLink(value: walletHolding) {
                        AccountRowView(balanceChartData: balanceChartViewModel.walletToBalanceChart[walletHolding.address.lowercased()] ?? BalanceChartData(), walletHolding: walletHolding)
                            .padding(.leading)
                    }
                }
            } else {
                AccountCellSectionPlaceHolderView
            }
        }
        .navigationDestination(for: WalletHolding.self) { walletHolding in
            AccountDetailView(walletHolding: walletHolding)
        }
    }
}




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}


