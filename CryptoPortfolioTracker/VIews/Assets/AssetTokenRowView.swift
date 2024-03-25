//
//  AssetTokenCellView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/5/24.
//

import SwiftUI

struct AssetTokenRowView: View {
    @EnvironmentObject private var marketViewModel: MarketViewModel
    var tokenInfo: Token
    @State var imageUrl: String?

    var body: some View {
        HStack {
            if let coin = marketViewModel.symbolToCoinMap[tokenInfo.symbol.lowercased()] {
                CoinImageView(coin: coin)
                    .frame(width: 30, height: 30)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            
            if let coin = marketViewModel.symbolToCoinMap[tokenInfo.symbol.lowercased()] {
                VStack(alignment: .leading, spacing: 3) {
                    Text(coin.name)
                        .font(.body)
                        .fontWeight(.bold)
                    HStack(spacing: 3) {
                        Text(tokenInfo.amount.asNumberString())
                            .font(.caption)
                            .fontWeight(.bold)
                        Text(tokenInfo.symbol)
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color.gray.opacity(0.8))

                }
            }
            
            Spacer()
            VStack(alignment: .trailing, spacing: 3) {
                Text(calculateTokenValueInUSD(tokenInfo: tokenInfo))
                    .font(.body)
                    .fontWeight(.bold)
                
                HStack {
                    if let priceChangePercentage24H = marketViewModel.symbolToCoinMap[tokenInfo.symbol.lowercased()]?.priceChangePercentage24H {
                        Image(systemName: priceChangePercentage24H >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(priceChangePercentage24H >= 0 ? Color.theme.green : Color.theme.red)
                        Text(priceChangePercentage24H.asPercentStringWithoutSign())
                            .font(.caption)
                            .fontWeight(.bold)
//                            .foregroundColor(Color.gray.opacity(0.8))
                            .foregroundColor(priceChangePercentage24H >= 0 ? Color.theme.green : Color.theme.red)
                    }

                }
            }

        }
        .task {
            do {
                let data = try await fetchTokenImage(tokenSymbol: tokenInfo.symbol)
                DispatchQueue.main.async
                {
                    imageUrl = data.url
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

    func calculateTokenValueInUSD(tokenInfo: Token) -> String {
        let balance = Double(tokenInfo.amount)
        let price = marketViewModel.symbolToCoinMap[tokenInfo.symbol.lowercased()]?.currentPrice
        if let price = price {
            let UsdValue = balance * price
            return UsdValue.asCurrencyWith2Decimals()
        } else {
            return "Unknown"
        }
    }
}

//struct AssetTokenCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetTokenCellView()
//    }
//}
