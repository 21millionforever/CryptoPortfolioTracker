//
//  AccountCellSectionPlaceHolderView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/15/24.
//

import SwiftUI

struct AccountCellSectionPlaceHolderView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 100) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10)
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 100) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10)
        }
    }
}

struct AccountCellSectionPlaceHolderView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCellSectionPlaceHolderView()
    }
}
