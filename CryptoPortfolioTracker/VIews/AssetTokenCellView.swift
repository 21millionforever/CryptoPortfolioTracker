//
//  AssetTokenCellView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/5/24.
//

import SwiftUI

struct AssetTokenCellView: View {
    
    var tokenInfo: Token
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .background(.red)
            }
            
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
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(.green)
                    
                    Text("0.69%")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray.opacity(0.8))
                }
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
