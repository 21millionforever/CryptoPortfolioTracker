//
//  ActivityDetailView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/18/24.
//

import SwiftUI

struct ActivityDetailView: View {
    var activity: ActivitiesResponse
    
    func timeStampToDate(timeStamp: String) -> String {
        if let timeStamp = TimeInterval(timeStamp) {
            let date = Date(timeIntervalSince1970: timeStamp)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy hh:mm a" // Adjust the format as needed
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            dateFormatter.locale = Locale(identifier: "en_US") // Ensure the date is in the expected locale

            return dateFormatter.string(from: date)        } else {
            return "Error"
        }
    }
    
    var body: some View {
        ScrollView {
            if (activity.type == "Receive") {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(timeStampToDate(timeStamp: activity.timeStamp))
                            .font(.headline)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 10)

                    VStack(alignment: .leading) {
                        Text("Status")
                            .font(.headline)
                        Text(activity.status)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Chain")
                            .font(.headline)
                        Text(activity.chian)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("From")
                            .font(.headline)
                        Text(activity.extraInfo.sender ?? "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("To")
                            .font(.headline)
                        Text(activity.extraInfo.receiver ?? "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Token")
                            .font(.headline)
                        Text("\(activity.extraInfo.tokenName ?? "Unknown") (\(activity.extraInfo.tokenSymbol ?? "Unknown"))")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Token Amount")
                            .font(.headline)
                        Text(activity.extraInfo.tokenAmount != nil ? String(formatNumber(activity.extraInfo.tokenAmount!)) : "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Hash")
                            .font(.headline)
                        Text(activity.hash)
                    }
                    
                    
                }
                .padding([.leading, .trailing])
                .navigationTitle("Received")
            }
            else if (activity.type == "Send") {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(timeStampToDate(timeStamp: activity.timeStamp))
                            .font(.headline)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 10)

                    VStack(alignment: .leading) {
                        Text("Status")
                            .font(.headline)
                        Text(activity.status)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Chain")
                            .font(.headline)
                        Text(activity.chian)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("From")
                            .font(.headline)
                        Text(activity.extraInfo.sender ?? "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("To")
                            .font(.headline)
                        Text(activity.extraInfo.receiver ?? "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Token")
                            .font(.headline)
                        Text("\(activity.extraInfo.tokenName ?? "Unknown") (\(activity.extraInfo.tokenSymbol ?? "Unknown"))")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Token Amount")
                            .font(.headline)
                        Text(activity.extraInfo.tokenAmount != nil ? String(formatNumber(activity.extraInfo.tokenAmount!)) : "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Gas Used")
                            .font(.headline)
                        if let GasUsedETH = activity.extraInfo.GasUsedETH {
                            Text("ETH: \(GasUsedETH)")
                        } else {
                            Text("ETH: Unknown")
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Hash")
                            .font(.headline)
                        Text(activity.hash)
                    }
                }
                .padding([.leading, .trailing])
                .navigationTitle("Sent")
            }
            else if (activity.type == "Swap") {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(timeStampToDate(timeStamp: activity.timeStamp))
                            .font(.headline)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 10)

                    VStack(alignment: .leading) {
                        Text("Status")
                            .font(.headline)
                        Text(activity.status)
                    }

                    VStack(alignment: .leading) {
                        Text("Chain")
                            .font(.headline)
                        Text(activity.chian)
                    }

                    VStack(alignment: .leading) {
                        Text("Sent Token Name")
                            .font(.headline)
                        Text(activity.extraInfo.sentTokenName ?? "Unknown")
                    }

                    VStack(alignment: .leading) {
                        Text("Sent Token Symbol")
                            .font(.headline)
                        Text(activity.extraInfo.sentTokenSymbol ?? "Unknown")
                    }

                    VStack(alignment: .leading) {
                        Text("Sent Token Amount")
                            .font(.headline)
                        Text(activity.extraInfo.sentTokenAmount != nil ? String(formatNumber(activity.extraInfo.sentTokenAmount!)) : "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Received Token Name")
                            .font(.headline)
                        Text(activity.extraInfo.receivedTokenName ?? "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Received Token Symbol")
                            .font(.headline)
                        Text(activity.extraInfo.receivedTokenSymbol ?? "Unknown")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Received Token Amount")
                            .font(.headline)
                        Text(activity.extraInfo.receivedTokenAmount != nil ? String(formatNumber(activity.extraInfo.receivedTokenAmount!)) : "Unknown")
                    }

                }
                .padding([.leading, .trailing])
                .navigationTitle("Swapped")

            }

        }
        
        

    }
}

//struct ActivityDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityDetailView()
//    }
//}
