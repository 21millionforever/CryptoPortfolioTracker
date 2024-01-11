//
//  ActivitySwapCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivitySwapCell: View {
    var activity: ActivitiesResponse
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.3.trianglepath")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.black)

            VStack(alignment: .leading, spacing: 0) {
                Text("Swapped")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            Spacer()
            
            
            VStack() {
                Text("+\(formatNumber(activity.extraInfo.receivedTokenAmount)) \(activity.extraInfo.receivedTokenSymbol ?? "Unknown")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("-\(formatNumber(activity.extraInfo.sentTokenAmount)) \(activity.extraInfo.sentTokenSymbol ?? "Unknown")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("$Unknown")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                
            }
 
        }
        .padding([.leading, .trailing])
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

//struct ActivitySwapCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivitySwapCell()
//    }
//}
