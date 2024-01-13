//
//  TotalBalanceView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import SwiftUI

struct TotalBalanceView: View {
    var balance: Double?
    var isBalanceLoaded: Bool
    
//    init(balance: Double?, isTotalBalanceLoaded: Bool) {
//        self.balance = balance
//        self.isTotalBalanceLoaded = isTotalBalanceLoaded
//    }
    
    var body: some View {
            HStack() {
                Text(formatAsCurrency(number: balance ?? 12))
                    .contentTransition(.numericText())
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
