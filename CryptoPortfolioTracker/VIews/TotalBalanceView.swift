//
//  TotalBalanceView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import SwiftUI

struct TotalBalanceView: View {
    
    @State private var balance: BalanceResponse?
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // 300 seconds = 5 minutes
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("Total Balance")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Spacer()

            }
            HStack() {
                if let balanceValue = balance?.balance {
                    Text(String(format: "%.2f", balanceValue))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
            .task {
                do {
                    balance = try await fetchTotalBalance(walletAddress: "0x98BEe23f076bE7B00fA0A2e243f821EE1344De77")
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
            .onReceive(timer) { _ in
                Task {
                    do {
                        balance = try await fetchTotalBalance(walletAddress: "0x98BEe23f076bE7B00fA0A2e243f821EE1344De77")
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
        
    }
    
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        TotalBalanceView()
    }
}
