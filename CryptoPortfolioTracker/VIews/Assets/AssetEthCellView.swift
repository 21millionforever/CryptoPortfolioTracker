//
//  AssetEthCellView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/16/24.
//

import SwiftUI

//struct AssetEthCellView: View {
//    var eth: Eth
//    @State var imageUrl: String?
//
//
//    var body: some View {
//        HStack {
//            AsyncImage(url: URL(string: imageUrl ?? "")) { image in
//                image.resizable()
//            } placeholder: {
//                ProgressView()
//            }
//            .frame(width: 40, height: 40)
//
//            VStack(alignment: .leading, spacing: 3) {
//                Text("Ethereum")
//                    .font(.body)
//                    .fontWeight(.bold)
//                HStack(spacing: 3) {
//                    Text(String(format: "%.2f", eth.balance))
//                        .font(.caption)
//                        .fontWeight(.bold)
//                    Text("ETH")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                }
//                .foregroundColor(Color.gray.opacity(0.8))
//
//            }
//            Spacer()
//            VStack(alignment: .trailing, spacing: 3) {
//                Text(calculateEthValueInUSD(eth: eth))
//                    .font(.body)
//                    .fontWeight(.bold)
//
//                    HStack {
//                        if(eth.price.diff >= 0) {
//                            Image(systemName: "arrowtriangle.up.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 10, height: 10)
//                                .foregroundColor(.green)
//                        } else {
//                            Image(systemName: "arrowtriangle.down.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 10, height: 10)
//                                .foregroundColor(.red)
//                        }
//
//                        Text("\(String(eth.price.diff))%")
//                            .font(.caption)
//                            .fontWeight(.bold)
//                            .foregroundColor(Color.gray.opacity(0.8))
//                    }
//
//
//
////                HStack {
////                    Image(systemName: "arrowtriangle.up.fill")
////                        .resizable()
////                        .aspectRatio(contentMode: .fit)
////                        .frame(width: 10, height: 10)
////                        .foregroundColor(.green)
////
////                    Text("0.69%")
////                        .font(.caption)
////                        .fontWeight(.bold)
////                        .foregroundColor(Color.gray.opacity(0.8))
////                }
//            }
//
//        }
//        .task {
//            do {
//                let data = try await fetchTokenImage(tokenSymbol: "eth")
//                DispatchQueue.main.async
//                {
//                    imageUrl = data.url
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
//    }
//
//    func calculateEthValueInUSD(eth: Eth) -> String {
//        let balance = Double(eth.balance)
//        let tokenValueInUSD = balance * Double(eth.price.rate)
//        return tokenValueInUSD.asCurrencyWith2Decimals()
//    }
//}

//struct AssetEthCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetEthCellView()
//    }
//}
