//
//  ActivityReceiveCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivityReceiveCell: View {
    var activity: ActivitiesResponse
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "arrowshape.turn.up.left.circle")
                .resizable()
                .frame(width: 50, height:55)
                .foregroundColor(.black)

            VStack(alignment: .leading) {
                Text(activity.type)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("from")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(activity.extraInfo.sender ?? "Unknown sender")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }

            }
            .frame(width: 150, height:55)

            
            
            VStack() {
                Text("+\(activity.extraInfo.tokenAmount ?? -1) \(activity.extraInfo.tokenSymbol ?? "Unknown")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("\(activity.extraInfo.tokenPrice ?? -1)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                
            }
            .frame(height:55)
 
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

//struct ActivityReceiveCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityReceiveCell()
//    }
//}
