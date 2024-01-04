//
//  ImportWalletView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/3/24.
//

import SwiftUI

struct ImportWalletView: View {
    
    @State private var walletAddress: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Enter a wallet addres")
                .font(.title)
                .fontWeight(.bold)
            Text("Please enter an Ethereum wallet address (starting with 0x)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .frame(width: 300)
            
            // Text field with a paste button
            VStack {
                TextField("Enter address or ENS", text: $walletAddress)
                    .padding()
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .cornerRadius(10)

                Button(action: {

                },
                       label: {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)


                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 5 / 50)

                        .background(Color.black.cornerRadius(30))
                        .foregroundStyle(.white)
                })
                
                .padding([.top], 20)
            }
            .padding(15)
            
        }
    }
    
    func saceWallet() {
        
    }
}

struct ImportWalletView_Previews: PreviewProvider {
    static var previews: some View {
        ImportWalletView()
    }
}
