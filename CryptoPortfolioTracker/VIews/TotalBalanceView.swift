//
//  TotalBalanceView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import SwiftUI

struct TotalBalanceView: View {
    var balance: Double?
    @Binding var isBalanceLoaded: Bool
    
//    init(balance: Double?, isBalanceLoaded: Bool) {
//        self.balance = balance
//        self.isBalanceLoaded = isBalanceLoaded
//    }
    
    var body: some View {
            HStack() {
                Text(formatAsCurrency(number: balance ?? 12))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .redacted(reason: isBalanceLoaded ? [] : .placeholder)
                
                Spacer()
            }
     
    }
    
}

//struct BalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        TotalBalanceView(balance: 2000)
//    }
//}
