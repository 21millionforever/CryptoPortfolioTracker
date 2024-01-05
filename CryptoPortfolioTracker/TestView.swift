//
//  TestView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/3/24.
//

import SwiftUI

import SwiftUI

struct TestView: View {

    var body: some View {
        Text("fdasfsd")
            .task {
                do {
                    print("Calling fetchWalletInfo")
                    let response = try await fetchWalletInfo(walletAddresses: ["daads", "dads"])
                    print(response)
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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()

    }
}
