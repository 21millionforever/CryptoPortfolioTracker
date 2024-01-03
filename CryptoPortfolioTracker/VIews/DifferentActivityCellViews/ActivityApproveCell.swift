//
//  ActivityApproveCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivityApproveCell: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "arrowshape.turn.up.left.circle")
                .resizable()
                .frame(width: 50, height:55)
                .foregroundColor(.black)
//                .background(.green)
            VStack(alignment: .leading) {
                Text("Approve")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)


            }
            .frame(width: 150, height:55)
//            .background(.red)
            
            Spacer()
 
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

struct ActivityApproveCell_Previews: PreviewProvider {
    static var previews: some View {
        ActivityApproveCell()
    }
}
