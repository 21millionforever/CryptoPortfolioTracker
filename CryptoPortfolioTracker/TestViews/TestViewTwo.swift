// Working
//struct ActivityView: View {
//    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
//
//    var address: String
//    @State private var activities: [ActivitiesResponse] = []
//    @State var tokenSymbolToImage: [String:String] = [:]
//
//
//
//    var body: some View {
//        VStack {
//            ForEach(groupedActivities.keys.sorted().reversed(), id: \.self) { date in
//                HStack {
//                    Text(date) // Date header
//                        .font(.headline)
//                    Spacer()
//                }
//                .padding(.leading)
//
//                ForEach(groupedActivities[date] ?? [], id: \.id) { activity in
//                    if activity.type == "Receive" {
//                        ActivityReceiveCell(activity: activity, imageUrl:  tokenSymbolToImage[activity.extraInfo.tokenSymbol ?? ""])
//                            .padding([.leading, .trailing], 10)
//                    } else if activity.type == "Send" {
//                        ActivitySendCell(activity: activity, imageUrl:  tokenSymbolToImage[activity.extraInfo.tokenSymbol ?? ""])
//                            .padding([.leading, .trailing], 10)
//                    } else if activity.type == "Swap" {
//                        ActivitySwapCell(activity: activity, sentTokenImageUrl: tokenSymbolToImage[activity.extraInfo.sentTokenSymbol ?? ""], receivedTokenImageUrl: tokenSymbolToImage[activity.extraInfo.receivedTokenSymbol ?? ""])
//                            .padding([.leading, .trailing], 10)
//                    } else if activity.type == "Approve" {
//                        ActivityApproveCell(imageUrl:  tokenSymbolToImage[activity.extraInfo.tokenSymbol ?? ""])
//                            .padding([.leading, .trailing], 10)
//                    }
//                }
//
//
//            }
//        }
//        .task {
//            var tempActivities: [ActivitiesResponse] = []
//            if activities.isEmpty {
//                do {
//                    tempActivities = try await fetchActivities(walletAddress: address)
//                    DispatchQueue.main.async {
//                        activities = tempActivities
//                    }
//                } catch APIError.invalidURL {
//                    print("Invalid url")
//                } catch APIError.invalidResponse {
//                    print("Invalid response")
//                } catch APIError.invalidData {
//                    print("Invalid Data")
//                } catch {
//                    // Handle other errors
//                    print("An unexpected error")
//                }
//            }
//            // Go through the activities and then get the images and store them in a dictionary
//            do {
//                for activity in tempActivities {
//                    if let tokenSymbol = activity.extraInfo.tokenSymbol {
//                        if !(tokenSymbolToImage.keys.contains(tokenSymbol)) {
//                            let image = try await fetchTokenImage(tokenSymbol: tokenSymbol)
//                            DispatchQueue.main.async {
//                                tokenSymbolToImage[tokenSymbol] = image.url
//                            }
//
//                        }
//                    }
//                    if let tokenSymbol = activity.extraInfo.sentTokenSymbol {
//                        if !(tokenSymbolToImage.keys.contains(tokenSymbol)) {
//                            let image = try await fetchTokenImage(tokenSymbol: tokenSymbol)
//                            DispatchQueue.main.async {
//                                tokenSymbolToImage[tokenSymbol] = image.url
//                            }
//                        }
//                    }
//
//                    if let tokenSymbol = activity.extraInfo.receivedTokenSymbol {
//                        if !(tokenSymbolToImage.keys.contains(tokenSymbol)) {
//                            let image = try await fetchTokenImage(tokenSymbol: tokenSymbol)
//                            DispatchQueue.main.async {
//                                tokenSymbolToImage[tokenSymbol] = image.url
//                            }
//                        }
//                    }
//                }
//            } catch APIError.invalidURL {
//                print("Invalid url")
//            } catch APIError.invalidResponse {
//                print("Invalid response")
//            } catch APIError.invalidData {
//                print("Invalid Data")
//            } catch {
//                // Handle other errors
//                print("An unexpected error")
//            }
//
//        }
//        .onReceive(timer) { _ in
//            print(tokenSymbolToImage)
//            Task {
//                do {
//                    activities = try await fetchActivities(walletAddress: address)
//                } catch APIError.invalidURL {
//                    print("Invalid url")
//                } catch APIError.invalidResponse {
//                    print("Invalid response")
//                } catch APIError.invalidData {
//                    print("Invalid Data")
//                } catch {
//                    // Handle other errors
//                    print("An unexpected error")
//                }
//            }
//        }
//
//    }
//
//
//    func timeStampToDate(from timeStamp: TimeInterval) -> String {
//        let date = Date(timeIntervalSince1970: timeStamp)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        dateFormatter.locale = Locale(identifier: "en_US")
//        let formattedDate = dateFormatter.string(from: date)
//        print(formattedDate)
//        return formattedDate
//    }
//
//    var groupedActivities: [String: [ActivitiesResponse]] {
//        let grouped = Dictionary(grouping: activities) { (activity) -> String in
//            guard let date = activity.timeStamp.toDate() else { return "Unknown Date" }
////            let a = date.toFormattedString()
//            return date.toFormattedString()
//        }
//        return grouped
//    }
//
//
//
//}
