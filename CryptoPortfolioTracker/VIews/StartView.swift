//
//  StartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/4/24.
//

import SwiftUI

struct StartView: View {
    @State var showingImportWalletView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("panda")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Button(
                    action: {
                        self.showingImportWalletView.toggle()
                    },
                    label: {
                      
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
                        .padding([.leading, .trailing])
                        
                    }
                )
                
                
            }
            
            .navigationDestination(isPresented: $showingImportWalletView, destination: {ImportWalletView(showingImportWalletView: $showingImportWalletView)})
        }

    }

}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
