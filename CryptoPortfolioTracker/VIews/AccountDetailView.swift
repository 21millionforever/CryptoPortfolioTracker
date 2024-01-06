//
//  AccountDetailView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/1/24.
//

import SwiftUI

struct AccountDetailView: View {
    var walletInfo: WalletInfo
    @Environment(\.presentationMode) var presentationMode
    
    init(walletInfo: WalletInfo) {
        self.walletInfo = walletInfo
        print("AccountDetailView is called")
    }

    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack() {
                        Text("Account Balance")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()

                    }
                    TotalBalanceView(balance: walletInfo.balanceInUSD)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundColor(.green)
                            
                        Text("$645.55")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                        Text("(0.69%)")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("Today")
                            .font(.subheadline)
                            .fontWeight(.light)
                
                    }
                    
                    Spacer().frame(height: 300)
  
                }
                .padding([.leading], 20)
                
                AssetActivityTabView(walletInfo: walletInfo)
          
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.green)
                    }
            )
    
    }
    
}

//struct AccountDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountDetailView(address: Config.test_wallet)
//    }
//}
