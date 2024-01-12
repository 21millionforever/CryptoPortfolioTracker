//
//  TotalBalanceView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/26/23.
//

import SwiftUI

struct TotalBalanceView: View {
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    var body: some View {
            HStack() {
                Text(formatAsCurrency(number: balance))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
            }
     
    }
    
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        TotalBalanceView(balance: 2000)
    }
}
