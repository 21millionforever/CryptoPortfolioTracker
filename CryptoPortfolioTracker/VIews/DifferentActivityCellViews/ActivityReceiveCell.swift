//
//  ActivityReceiveCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

//struct ActivityReceiveCell: View {
//    var activity: ActivitiesResponse
//
//    var body: some View {
//        HStack(spacing: 0) {
//            Image(systemName: "arrowtriangle.up.fill")
//                .resizable()
//                .frame(width: 50, height:55)
//                .foregroundColor(.black)
//
//            VStack(alignment: .leading) {
//                Text(activity.type)
//                    .fontWeight(.bold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                HStack {
//                    Text("from")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//
//                    Text(activity.extraInfo.sender ?? "Unknown sender")
//                        .font(.subheadline)
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                }
//
//            }
//            .frame(width: 150, height:55)
//
//
//
//            VStack() {
//                Text("+\(formatNumber(activity.extraInfo.tokenAmount)) \(activity.extraInfo.tokenSymbol ?? "Unknown")")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .foregroundColor(.green)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                Text("\(activity.extraInfo.tokenPrice ?? -1)")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//
//            }
//            .frame(height:55)
//
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(radius: 2)
//    }
//}

struct ActivityReceiveCell: View {
    var activity: ActivitiesResponse
    
    var body: some View {
        HStack {
            Image(systemName: "arrowtriangle.up.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height:30)
                .foregroundColor(.green)
            

            VStack(alignment: .leading, spacing: 0) {
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
                        .frame(width: 100, height: 30)
                }
            }

            Spacer()
            
            VStack() {
                Text("+\(formatNumber(activity.extraInfo.tokenAmount)) \(activity.extraInfo.tokenSymbol ?? "Unknown")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
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

//struct ActivityReceiveCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityReceiveCell()
//    }
//}
