//
//  AccountCellView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/1/24.
//

import SwiftUI
import Charts
import Foundation



struct AccountCellView: View {
    var address: String
    @State private var balance: BalanceResponse?
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // 300 seconds = 5 minutes
    
    var body: some View {
        VStack {
            HStack(spacing:0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack() {
                        Image("SVG_MetaMask_Icon_Color")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)

                        Text("MetaMask")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        
                        Text(address)
                            .foregroundColor(.black)
                    }
                    .frame(height:40)

                    HStack() {
                        Chart(data) {
                            LineMark(
                                x: .value("Month", $0.date),
                                y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                            )
                        }
                        .chartYAxis(.hidden)
                        .chartXAxis(.hidden)
                        .foregroundStyle(.red)
                        .padding([.top],30)
                    }
                    .frame(width: 250, height: 70)

                    .task {
                        do {
                            balance = try await fetchTotalBalance(walletAddress: address)
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
                                balance = try await fetchTotalBalance(walletAddress: address)
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
                .frame(width: 300, height: 110)

                VStack(spacing: 0) {

                    if let balanceValue = balance?.balance {

                        Text("$\(String(format: "%.2f", balanceValue))")
                            .font(.body)
                            .fontWeight(.regular)
                            .background(.green)

                    }
                }
                .frame(width: 100, height: 110)

            }
            Divider()
        }
        
    }
}

struct AccountCellView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCellView(address: Config.test_wallet)
    }
}
