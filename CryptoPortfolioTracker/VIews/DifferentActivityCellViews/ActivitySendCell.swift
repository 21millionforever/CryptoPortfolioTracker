//
//  ActivitySendCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivitySendCell: View {
    var activity: ActivitiesResponse
    
    var body: some View {
        HStack {
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height:30)
                .foregroundColor(.red)
            VStack(alignment: .leading, spacing: 0) {
                Text("Sent")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("to")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(activity.extraInfo.receiver ?? "Unknown receiver")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(width: 100, height: 30)
                }
            }
            Spacer()
            
            
            VStack() {
                Text("-\(formatNumber(activity.extraInfo.tokenAmount)) \(activity.extraInfo.tokenSymbol ?? "Unknown")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("\(activity.extraInfo.tokenPrice ?? -1)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                
            }
 
        }
        .frame(height:55)
        .padding([.leading, .trailing])
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

//struct ActivitySendCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivitySendCell()
//    }
//}
