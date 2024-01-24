//
//  BottomSheetView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/3/24.
//

import SwiftUI

struct BottomSheetView: View {
    @Binding var navigateToImportWalletView: Bool
    @Binding var showingBottomMenu: Bool
    
    var body: some View {
        Button(action: {
            showingBottomMenu = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
                navigateToImportWalletView = true
            }
        }, label: {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Add A New Wallet")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("The wallet is only for viewing")
                        .font(.caption)
                }
                .foregroundColor(.black)
                Spacer()
                Image(systemName: "qrcode.viewfinder")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .foregroundColor(.black)
                    
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding()
        
            
        })
    }
}

//struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomSheetView(navigateToImportWalletView: false, showingBottomMenu: false)
//    }
//}
