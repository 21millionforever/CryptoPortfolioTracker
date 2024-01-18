//
//  AssetTokenCellView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/5/24.
//

import SwiftUI

struct AssetTokenCellView: View {
    
    var tokenInfo: Token
    @State var imageUrl: String?
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: imageUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            

            
            VStack(alignment: .leading, spacing: 3) {
                Text(tokenInfo.tokenInfo.name)
                    .font(.body)
                    .fontWeight(.bold)
                HStack(spacing: 3) {
                    Text(formatTokenBalance(tokenInfo: tokenInfo))
                        .font(.caption)
                        .fontWeight(.bold)
                    Text(tokenInfo.tokenInfo.symbol)
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .foregroundColor(Color.gray.opacity(0.8))

            }
            Spacer()
            VStack(alignment: .trailing, spacing: 3) {
                Text(calculateTokenValueInUSD(tokenInfo: tokenInfo))
                    .font(.body)
                    .fontWeight(.bold)
                HStack {
                    if(tokenInfo.tokenInfo.price.diff >= 0) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.green)
                        
                        Text("\(String(format: "%.2f", tokenInfo.tokenInfo.price.diff))%")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray.opacity(0.8))
                        
                    } else {
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.red)
                        Text("\(String(format: "%.2f", tokenInfo.tokenInfo.price.diff * -1))%")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray.opacity(0.8))
                    }
                    
                    
                   
                }
            }
            
        }
        .task {
            do {
                let data = try await fetchTokenImage(tokenSymbol: tokenInfo.tokenInfo.symbol)
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
    
    
    func formatTokenBalance(tokenInfo: Token) -> String {
        let balance = Double(tokenInfo.balance)
        let decimals = Double(tokenInfo.tokenInfo.decimals) ?? 18
        let formattedBalance = balance / pow(10.0, decimals)
        return String(format: "%.2f", formattedBalance)
    }
    
    func calculateTokenValueInUSD(tokenInfo: Token) -> String {
        let balance = Double(tokenInfo.balance)
        let decimals = Double(tokenInfo.tokenInfo.decimals) ?? 18
        let formattedBalance = balance / pow(10.0, decimals)
        let tokenValueInUSD = formattedBalance * tokenInfo.tokenInfo.price.rate
        return formatAsCurrency(number: tokenValueInUSD)
    }
}

//struct AssetTokenCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetTokenCellView()
//    }
//}
