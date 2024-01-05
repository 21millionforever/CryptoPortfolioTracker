//
//  TotalBalanceView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import SwiftUI

// TODO: Fix the issue of calling getbalance api too many times
struct TotalBalanceView: View {
    var balance: Double = 0
    
    var body: some View {
            HStack() {
                Text(String(format: "%.2f", balance))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
            }
     
    }
    
}

//struct TotalBalanceView: View {
//    var addresses: [String]
//    @State private var totalBalance: Double = 0
//
//    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // 300 seconds = 5 minutes
//
//    var body: some View {
//
//            HStack() {
//                Text(String(format: "%.2f", totalBalance))
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//
//                Spacer()
//            }
//            .task {
//                print("fetchTotalBalance is called")
//                    totalBalance = 0
//                    for address in addresses {
//                        do {
//                            let response = try await fetchTotalBalance(walletAddress: address)
//                            totalBalance += response.balance
//                        } catch APIError.invalidURL {
//                            print("Invalid url")
//                        } catch APIError.invalidResponse {
//                            print("Invalid response")
//                        } catch APIError.invalidData {
//                            print("Invalid Data")
//                        } catch {
//                            // Handle other errors
//                            print("An unexpected error")
//                        }
//
//                    }
//            }
//            .onReceive(timer) { _ in
//                Task {
//                    totalBalance = 0
//                    for address in addresses {
//                        do {
//                            let response = try await fetchTotalBalance(walletAddress: address)
//                            totalBalance += response.balance
//                        } catch APIError.invalidURL {
//                            print("Invalid url")
//                        } catch APIError.invalidResponse {
//                            print("Invalid response")
//                        } catch APIError.invalidData {
//                            print("Invalid Data")
//                        } catch {
//                            // Handle other errors
//                            print("An unexpected error")
//                        }
//
//                    }
//                }
//
//            }
//
//
//
//
//    }
//
//}



struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        TotalBalanceView(balance: 2000)
    }
}
