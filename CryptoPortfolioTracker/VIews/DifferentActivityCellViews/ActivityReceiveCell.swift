//
//  ActivityReceiveCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI


struct ActivityReceiveCell: View {
    var activity: ActivitiesResponse
    var imageUrl: String?
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height:30)
                    .foregroundColor(.green)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading, spacing: 0) {
                Text("Received")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 2) {
                    Text("from")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(activity.extraInfo.sender ?? "Unknown sender")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(width: 100, height: 30)
                }
            }

            Spacer()
            
            VStack() {
//                Text("+\(formatNumber(activity.extraInfo.tokenAmount)) \(activity.extraInfo.tokenSymbol ?? "Unknown")")
                Text("+\(activity.extraInfo.tokenAmount?.asNumberString() ?? "Unknown") \(activity.extraInfo.tokenSymbol ?? "Unknown")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .trailing)
//                Text("\(activity.extraInfo.tokenPrice ?? -1)")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .frame(maxWidth: .infinity, alignment: .trailing)

            }
 
        }
        .frame(height:55)
        .padding([.leading, .trailing])
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(radius: 2)
        
    }
}

//struct ActivityReceiveCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityReceiveCell()
//    }
//}
