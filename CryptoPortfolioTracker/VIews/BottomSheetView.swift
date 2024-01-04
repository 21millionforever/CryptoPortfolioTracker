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
        Button("Navigate to New View") {
            showingBottomMenu = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
                navigateToImportWalletView = true
            }

        }
    }
}

//struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomSheetView()
//    }
//}
