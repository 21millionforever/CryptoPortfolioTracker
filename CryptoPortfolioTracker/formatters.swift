//
//  formatters.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/5/24.
//

import Foundation



func formatAsCurrency(number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "en_US") // Adjust the locale to your target audience
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2

    return formatter.string(from: NSNumber(value: number)) ?? "$0.00"
}

// 12345.6789 to 12,345.679
func formatNumber(_ number: Double?) -> String {
    guard let number = number else {
        return "-1" // Default value if number is nil
    }

    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2

    return formatter.string(from: NSNumber(value: number)) ?? ""
}
