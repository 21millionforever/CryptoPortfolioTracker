//
//  ActivitySendCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivitySendCell: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "arrowshape.turn.up.left.circle")
                .resizable()
                .frame(width: 50, height:55)
                .foregroundColor(.black)
//                .background(.green)
            VStack(alignment: .leading) {
                Text("Sent")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("to")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(Config.test_wallet)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }

            }
            .frame(width: 150, height:55)
//            .background(.red)
            
            
            VStack() {
                Text("-1 ETH")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("$2,260.79")
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

struct ActivitySendCell_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySendCell()
    }
}
