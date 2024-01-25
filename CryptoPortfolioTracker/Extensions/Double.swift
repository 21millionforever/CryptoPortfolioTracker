//
//  Double.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/24/24.
//

import Foundation

extension Double {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency as String with 2 decimal places
    /// ```
    /// Convert 12.32 to "$12.32"
    /// ```
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into string representation
    /// ```
    /// Convert 1.2223 to "1.22"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into string representation with percent symbol
    /// ```
    /// Convert 1.2223 to "1.22%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
