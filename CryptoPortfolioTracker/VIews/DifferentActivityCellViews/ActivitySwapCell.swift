//
//  ActivitySwapCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivitySwapCell: View {
    var activity: ActivitiesResponse
    var sentTokenImageUrl: String?
    var receivedTokenImageUrl: String?
    
    var body: some View {
        HStack {
            ZStack {
               
                AsyncImage(url: URL(string: sentTokenImageUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                       
                        
                } placeholder: {
                    ProgressView()
                }
                
                AsyncImage(url: URL(string: receivedTokenImageUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.green)
                        .offset(x: 10, y: 10) // Example offset
                } placeholder: {
                    ProgressView()
                }

            }

            


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
//                Text("$Unknown")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                
            }
 
        }
        .padding([.leading, .trailing])
        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(radius: 2)
    }
}

//struct ActivitySwapCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivitySwapCell()
//    }
//}
