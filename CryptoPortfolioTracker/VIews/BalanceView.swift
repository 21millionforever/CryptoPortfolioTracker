//
//  BalanceView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import SwiftUI

struct BalanceView: View {
    var balance: Double?
    var isBalanceLoaded: Bool

    
    var body: some View {
        VStack(spacing: 10) {
            HStack() {
                Text(formatAsCurrency(number: balance ?? 12))
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .redacted(reason: isBalanceLoaded ? [] : .placeholder)
                   
                Spacer()
            }
            
//            HStack(spacing: 3) {
//                Image(systemName: "arrowtriangle.up.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 15, height: 15)
//                    .foregroundColor(.green)
//                
//                Spacer()
//                    .frame(width: 5)
//
//                Text(formatAsCurrency(number: balance ?? 12))
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//
//                Text("(100.0%)")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//
//                Text("All Time")
//                    .font(.subheadline)
//                    .fontWeight(.light)
//                
//                Spacer()
//
//            }
            
            
        }

    }
        
    
}

//struct BalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        TotalBalanceView(balance: 2000)
//    }
//}
