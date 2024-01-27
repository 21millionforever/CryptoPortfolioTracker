//
//  UIApplication.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/26/24.
//

import Foundation
import SwiftUI
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
