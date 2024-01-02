//
//  ActivityView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivityView: View {
    @State private var activities: [ActivitiesResponse]?
    
    var body: some View {
        VStack {
            Text("Activity View")
        }
        .task {
            do {
                activities = try await fetchActivities(walletAddress: Config.test_wallet)
                print(activities)
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

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
