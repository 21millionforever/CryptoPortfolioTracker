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
    @EnvironmentObject var walletInfoViewModel: WalletInfoViewModel
    @EnvironmentObject var sharedDataModel : SharedDataModel
    
    @State private var showBottomMenu: Bool = false
    @State var showingImportWalletView: Bool = false
    @State private var selectedTab = "All"
    let tabs = ["LIVE", "1D", "1W", "1M", "3M", "All"]
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    TotalBalanceView
                        .padding(.leading)
                    
                    ChartTabView(selectedTab: $selectedTab)
                    
                    AccountsHeaderView
                        .padding(.leading)

                    AccountsSectionView
                    

                }
                .navigationTitle("Total Balance")

            }
            .navigationDestination(for: WalletInfo.self) { walletInfo in
                AccountDetailView(walletInfo: walletInfo)
            }
            .navigationDestination(isPresented: $showingImportWalletView, destination: {ImportWalletView(showingImportWalletView: $showingImportWalletView)})
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    TopMenuButtonView
                    .sheet(isPresented: $showBottomMenu) {
                        bottomSheetView()
                    }
                }
            }
            .onChange(of: sharedDataModel.addresses) { newAddresses in
                guard let lastAddress = newAddresses.last else { return }
                Task {
                    await balanceChartViewModel.loadSingleAddressChartData(address: lastAddress)
                }
            }
            
            
        }
    }
}

extension ContentView {
    
    private var TotalBalanceView: some View {
        VStack(spacing: 10) {
            HStack() {
                Text(walletInfoViewModel.totalBalance?.asCurrencyWith2Decimals() ?? "Error")
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .redacted(reason: walletInfoViewModel.isWalletsInfoLoaded ? [] : .placeholder)
                   
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
                ForEach(walletInfoViewModel.walletsInfo, id: \.id) { walletInfo in
                    NavigationLink(value: walletInfo) {
                        AccountCellView(walletInfo: walletInfo)
                            .padding(.leading)
                    }
                }
            } else {
                AccountCellSectionPlaceHolderView
            }
        }
    }
}




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


