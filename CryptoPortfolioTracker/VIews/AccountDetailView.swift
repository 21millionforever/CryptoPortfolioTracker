//
//  AccountDetailView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/1/24.
//

import SwiftUI

struct AccountDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView()
    }
}
