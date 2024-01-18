//
//  ActivityApproveCell.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI

struct ActivityApproveCell: View {
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
            VStack(alignment: .leading) {
                Text("Approve")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
 
        }
        .frame(height:55)
        .padding([.leading, .trailing])
        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(radius: 2)
    }
}

struct ActivityApproveCell_Previews: PreviewProvider {
    static var previews: some View {
        ActivityApproveCell()
    }
}
