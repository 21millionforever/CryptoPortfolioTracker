//
//  ActivityView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

// Working
struct ActivityView: View {
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var address: String
    @State private var activities: [ActivitiesResponse] = []
    @State var tokenSymbolToImage: [String:String] = [:]



    var body: some View {
        VStack {
            ForEach(groupedActivities.keys.sorted().reversed(), id: \.self) { date in
                HStack {
                    Text(date) // Date header
                        .font(.headline)
                    Spacer()
                }
                .padding(.leading)

                ForEach(groupedActivities[date] ?? [], id: \.id) { activity in
                    NavigationLink(value: activity) {
                        if activity.type == "Receive" {
                            ActivityReceiveCell(activity: activity, imageUrl:  tokenSymbolToImage[activity.extraInfo.tokenSymbol ?? ""])
                                .padding([.leading, .trailing], 10)
                        } else if activity.type == "Send" {
                            ActivitySendCell(activity: activity, imageUrl:  tokenSymbolToImage[activity.extraInfo.tokenSymbol ?? ""])
                                .padding([.leading, .trailing], 10)
                        } else if activity.type == "Swap" {
                            ActivitySwapCell(activity: activity, sentTokenImageUrl: tokenSymbolToImage[activity.extraInfo.sentTokenSymbol ?? ""], receivedTokenImageUrl: tokenSymbolToImage[activity.extraInfo.receivedTokenSymbol ?? ""])
                                .padding([.leading, .trailing], 10)
                        } else if activity.type == "Approve" {
                            ActivityApproveCell(imageUrl:  tokenSymbolToImage[activity.extraInfo.tokenSymbol ?? ""])
                                .padding([.leading, .trailing], 10)
                        }
                      
                    }

                }
                    
            }
            .navigationDestination(for: ActivitiesResponse.self) { activity in
               
                ActivityDetailView(activity: activity)

            }
        }
//        .navigationDestination(for: ActivitiesResponse.self) { activity in
//            Text("dasda")
        .task {
            var tempActivities: [ActivitiesResponse] = []
            if activities.isEmpty {
                do {
                    tempActivities = try await fetchActivities(walletAddress: address)
                    DispatchQueue.main.async {
                        activities = tempActivities
                    }
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
            // Go through the activities and then get the images and store them in a dictionary
            do {
                for activity in tempActivities {
                    if let tokenSymbol = activity.extraInfo.tokenSymbol {
                        if !(tokenSymbolToImage.keys.contains(tokenSymbol)) {
                            let image = try await fetchTokenImage(tokenSymbol: tokenSymbol)
                            DispatchQueue.main.async {
                                tokenSymbolToImage[tokenSymbol] = image.url
                            }

                        }
                    }
                    if let tokenSymbol = activity.extraInfo.sentTokenSymbol {
                        if !(tokenSymbolToImage.keys.contains(tokenSymbol)) {
                            let image = try await fetchTokenImage(tokenSymbol: tokenSymbol)
                            DispatchQueue.main.async {
                                tokenSymbolToImage[tokenSymbol] = image.url
                            }
                        }
                    }

                    if let tokenSymbol = activity.extraInfo.receivedTokenSymbol {
                        if !(tokenSymbolToImage.keys.contains(tokenSymbol)) {
                            let image = try await fetchTokenImage(tokenSymbol: tokenSymbol)
                            DispatchQueue.main.async {
                                tokenSymbolToImage[tokenSymbol] = image.url
                            }
                        }
                    }
                }
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
            print(tokenSymbolToImage)
            Task {
                do {
                    let tempActivities = try await fetchActivities(walletAddress: address)
                    DispatchQueue.main.async {
                        activities = tempActivities
                    }
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


    func timeStampToDate(from timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let formattedDate = dateFormatter.string(from: date)
        print(formattedDate)
        return formattedDate
    }

    var groupedActivities: [String: [ActivitiesResponse]] {
        let grouped = Dictionary(grouping: activities) { (activity) -> String in
            guard let date = activity.timeStamp.toDate() else { return "Unknown Date" }
            return date.toFormattedString()
        }
        return grouped
    }



}


extension String {
    func toDate() -> Date? {
        guard let timeInterval = TimeInterval(self) else { return nil }
        return Date(timeIntervalSince1970: timeInterval)
    }
}

extension Date {
    func toFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}


//struct ActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView()
//    }
//}
